from django.db.models import OneToOneField

from rest_framework import viewsets, exceptions

class OneToOneViewSet(viewsets.ModelViewSet):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.model = self.queryset.model
        self.related_attribute = self.get_related_model().name

    def get_object(self):
        pk = self.kwargs.get('pk')
        if pk is None:
            raise exceptions.NotFound('Primary key not provided')
        filter_kwargs = {f"{self.related_attribute}__id": pk}
        print(filter_kwargs)
        try:
            return self.model.objects.get(**filter_kwargs)
        except self.model.DoesNotExist:
            raise exceptions.NotFound(f'{self.model.__name__} not found')
        
    def get_related_model(self):
        for field in self.model._meta.get_fields():
            print(field.one_to_one)
            if field.one_to_one or isinstance(field, OneToOneField):
                print(field)
                return field
        raise exceptions.NotFound('Related model not found')

from rest_framework import viewsets, status, response
from rest_framework.decorators import action
from utils.pagination import CustomPagination
from rest_framework import viewsets, status, response
from rest_framework.decorators import action
from utils.pagination import CustomPagination
import functools
import functools
from rest_framework.decorators import action
from rest_framework.decorators import action
from rest_framework import viewsets, status
from rest_framework.response import Response

from rest_framework import viewsets, response, status
from rest_framework.decorators import action
from utils.pagination import CustomPagination

class BaseModelViewSet(viewsets.ModelViewSet):
    pagination_class = CustomPagination
    action_serializer_class = {}
    many_related_queryset = {}

    def get_serializer_class(self):
        return self.action_serializer_class.get(
            self.action,
            super().get_serializer_class()
        )
    
    # @property
    # def _action_exists(cls):
    #     print(hasattr(cls, 'action'), cls.action != 'paginate_and_response')
    #     return hasattr(cls, 'action') and cls.action != 'paginate_and_response'

    def get_object(self):
        pk = self.kwargs.get('pk', None)
        # action = None
        # if not self._action_exists:
        #     self.uri = [x for x in self.request.build_absolute_uri().split('/') if x][-1].replace('-', '_')
        #     action = self.uri
        # else:
        #     action = self.action

        if self.action in self.many_related_queryset.keys():
            try:
                instance = self.queryset.model.objects.get(pk=pk)
            except self.queryset.model.DoesNotExist:
                return response.Response(
                    {
                        "message": f"{self.queryset.model.__name__} not found."
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
            return self.many_related_queryset.get(self.action)(instance)
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
            page = self.paginate_queryset(queryset_or_instance)
            if page is not None:
                serializer = self.get_serializer(page, many=True)
                return self.get_paginated_response(serializer.data)
            serializer = self.get_serializer(queryset_or_instance, many=True)
            return response.Response(serializer.data, status=status.HTTP_200_OK)

        serializer = self.get_serializer(queryset_or_instance)
        return response.Response(serializer.data, status=status.HTTP_200_OK)

    @classmethod
    def create_action(cls, action_name):
        # @functools.wraps(cls.paginate_and_response)
        def action_method(self, request, *args, **kwargs):
            return self.paginate_and_response(request, *args, **kwargs)
        action_method.__name__ = action_name
        action_method.__doc__ = f"Custom action method for {action_name.replace('_', ' ')}"
        action_method = action(detail=True, methods=["GET"], url_path=action_name.replace("_", "-"))(action_method)
        return action_method


