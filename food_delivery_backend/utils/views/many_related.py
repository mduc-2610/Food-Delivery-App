from rest_framework import viewsets, status, response
from rest_framework.decorators import action
from rest_framework.response import Response
from utils.pagination import CustomPagination
from django.db import models
from utils.mixins import DynamicFilterMixin

class ManyRelatedViewSet(viewsets.ModelViewSet):
    pagination_class = CustomPagination
    many_related_serializer_class = {}
    many_related = {}

    def get_serializer_context(self):
        context = super().get_serializer_context()
        list_detail = self.many_related.get(self.action, {}).get('list_detail', True)
        context.update({'detail': list_detail})
        return context

    def get_serializer_class(self):
        return self.many_related.get(self.action, {}).get(
            'serializer_class',
            self.many_related_serializer_class.get(
                self.action,
                super().get_serializer_class()
            )
        )

    def get_object(self):
        pk = self.kwargs.get('pk', None)
        model = self.queryset.model
        params = self.request.query_params
        filter_kwargs = {}
        for field in self.get_serializer_class().Meta.model._meta.get_fields():
            if isinstance(field, models.ForeignKey) and params.get(field.name):
                filter_kwargs.update({
                    f'{field.name}__id': params.get(field.name)
                })
        
        # print(filter_kwargs, pretty=True)

        if self.action in self.many_related:
            try:
                instance = model.objects.get(pk=pk)
            except self.queryset.model.DoesNotExist:
                return None
            
            if filter_kwargs:
                queryset = self.many_related[self.action]['queryset'](instance).filter(**filter_kwargs)
            else:
                queryset = self.many_related[self.action]['queryset'](instance)
            return queryset
        return super().get_object()

    def paginate_and_response(self, request, *args, **kwargs):
        queryset_or_instance = self.get_object()
        if queryset_or_instance is None:
            return response.Response(
                {
                    "message": f"{self.queryset.model.__name__} not found."
                },
                status=status.HTTP_404_NOT_FOUND
            )

        if isinstance(queryset_or_instance, list) or hasattr(queryset_or_instance, '__iter__'):
            if self.many_related.get(self.action).get('dynamic_filter', False):
                    queryset_or_instance = DynamicFilterMixin.filter_queryset(self, queryset_or_instance)

            page = self.paginate_queryset(queryset_or_instance)
            is_paginated = self.many_related.get(self.action).get('pagination', True)
            if is_paginated and page is not None:
                serializer = self.get_serializer(page, many=True)
                return self.get_paginated_response(serializer.data)
            serializer = self.get_serializer(queryset_or_instance, many=True)
            return response.Response(serializer.data, status=status.HTTP_200_OK)

        serializer = self.get_serializer(queryset_or_instance)
        return response.Response(serializer.data, status=status.HTTP_200_OK)

    @classmethod
    def create_action(cls, action_name, methods, url_path):
        def action_method(self, request, *args, **kwargs):
            if request.method == 'POST':
                serializer_class = self.many_related.get(self.action, {}).get('create_serializer_class', None)
                if serializer_class:                    
                    pk = kwargs.pop('pk')
                    serializer = serializer_class(data={
                        **request.data,
                        'user': pk
                    })
                    serializer.is_valid(raise_exception=True)  
                    instance = serializer.save()
                    return response.Response(serializer.data, status=status.HTTP_201_CREATED)
            
            return self.paginate_and_response(request, *args, **kwargs)
        action_method.__name__ = action_name
        action_decorator = action(detail=True, methods=methods, url_path=url_path)
        action_method = action_decorator(action_method)

#         action_code = f"""
# @action(detail=True, methods={methods}, url_path='{url_path}')
# def {action_name}(self, request, *args, **kwargs):
#     return self.paginate_and_response(request)
# """     
#         exec(action_code)
#         action_method = locals()[action_name]
        return action_method

    @classmethod
    def init_many_related_actions(cls):
        for action_name, config in cls.many_related.items():
            config_action = config.get('action')
            if config_action:
                methods, url_path = config_action
                method = cls.create_action(action_name, methods, url_path)
                setattr(cls, action_name, method)

    @classmethod
    def init_many_related(cls):
        cls.model = cls.queryset.model
        for key, value in cls.many_related_serializer_class.items():
            if isinstance(key, tuple) or isinstance(key, list):
                cls.many_related_serializer_class.pop(key)
                for _key in key:
                    cls.many_related_serializer_class.update({_key: value})

        def get_many_related_or_default(field_name, attribute, default=None):
            if attribute == 'action':
                return cls.many_related.get(field_name, {}) \
                    .get(attribute, default if default is not None else (['GET', ], field_name.replace('_', '-')))
            elif attribute == 'queryset':
                return cls.many_related.get(field_name, {}) \
                    .get(attribute, default if default is not None else lambda instance, field_name=field_name: getattr(instance, field_name).all())
            return cls.many_related.get(field_name, {}) \
                    .get(attribute, default)
        
        dynamic_filter_all = cls.many_related.pop('dynamic_filter_all', None)
        list_detail_all = cls.many_related.pop('list_detail_all', None)
        if not dynamic_filter_all:
            dynamic_filter_all = cls.many_related_serializer_class.pop('dynamic_filter_all', None)
        if not list_detail_all:
            list_detail_all = cls.many_related_serializer_class.pop('list_detail_all', None)

        for field, _serializer_class in cls.many_related_serializer_class.items():
            if hasattr(cls.model, field):
                cls.many_related.update({
                        field: {
                            'action': get_many_related_or_default(field, 'action'),
                            'queryset': get_many_related_or_default(field, 'queryset'),
                            'serializer_class': get_many_related_or_default(field, 'serializer_class', _serializer_class), 
                            'create_serializer_class': get_many_related_or_default(field, 'create_serializer_class', _serializer_class),
                            'update_serializer_class': get_many_related_or_default(field, 'update_serializer_class', _serializer_class),
                            'pagination': cls.many_related.get(field, {}).get('pagination', True),
                            'dynamic_filter': get_many_related_or_default(field, 'dynamic_filter', False) if dynamic_filter_all is None else dynamic_filter_all,
                            'list_detail': get_many_related_or_default(field, 'list_detail', True) if list_detail_all is None else list_detail_all,
                        }
                    })
        # for field in cls.model._meta.get_fields():
        #     if field.one_to_many or field.many_to_many:
        #         _serializer_class = cls.many_related_serializer_class.get(field.name)
        #         if _serializer_class:
        #             cls.many_related.update({
        #                 field.name: {
        #                     'action': (['GET'], field.name.replace('_', '-')),
        #                     'queryset': lambda instance, field_name=field.name: getattr(instance, field_name).all(),
        #                     'serializer_class': _serializer_class
        #                 }
        #             })
    
    def __init_subclass__(cls, **kwargs):
        super().__init_subclass__(**kwargs)
        cls.init_many_related()
        cls.init_many_related_actions()
