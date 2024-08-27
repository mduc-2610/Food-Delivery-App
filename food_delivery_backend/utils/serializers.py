from rest_framework import serializers
from django.db.models import OneToOneField
from utils.function import get_related_url
from django.apps import apps

class CustomRelatedModelSerializer(serializers.ModelSerializer):
    _initialized = False

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.detail = self.context.get('detail', True)
        self.request = self.context.get('request')
        self.query_params = self.request.query_params
        self.separator = self.query_params.get('separator', ',')
        self.model = self.Meta.model
        self.endpoint = '-'.join([x.lower() for x in self.model.__name__.split(' ')])

        self.one_related_fields = []
        self.many_related_fields = []

        self.one_related_exclude_fields = self.get_list_param('one_related_exclude_fields', separator=self.separator)
        self.many_related_exclude_fields = self.get_list_param('many_related_exclude_fields', separator=self.separator)
        if self.detail:
            one_related_fields = self.get_list_param('one_related_fields', default='__all__', separator=self.separator)
            many_related_fields = self.get_list_param('many_related_fields', default='__all__', separator=self.separator)

            if (one_related_fields and self.one_related_exclude_fields) or (many_related_fields and self.many_related_exclude_fields):
                one_related_fields = ['__all__']
                many_related_fields = ['__all__']
            if not one_related_fields or one_related_fields[0] == "__all__":
                self.one_related_fields = [field.name for field in self.model._meta.get_fields() if field.one_to_one]
            else:
                self.one_related_fields = one_related_fields
    
            if not many_related_fields or many_related_fields[0] == "__all__":
                self.many_related_fields = [field.name for field in self.model._meta.get_fields() if field.one_to_many or field.many_to_many]
            else:
                self.many_related_fields = many_related_fields

        self.one_related_fields = [field for field in self.one_related_fields if field not in self.one_related_exclude_fields]
        self.many_related_fields = [field for field in self.many_related_fields if field not in self.many_related_exclude_fields]
        self.one_related_serializer_class = {}
        self.many_related_serializer_class = {}

    def get_list_param(self, param_name, default='', separator=','):
        param_value = self.query_params.get(param_name, default)
        if param_value:
            return [field.strip() for field in param_value.split(separator) if field.strip()]
        return []

    def serialize_related_object(self, related_serializer_class, obj, related, many=False, context={}):
        if self.request and self.detail:
            related_obj = getattr(obj, related, None)
            if related_obj:
                related_serializer = related_serializer_class(related_obj, many=many, context=context)
                return related_serializer.data
        return None

    def to_representation(self, instance):
        data = super().to_representation(instance)
        for field in self.one_related_fields:   
            if not isinstance(data.get(field), dict):
                related_serializer_class = self.one_related_serializer_class.get(field)
                if related_serializer_class != 'primary_related_field':
                    if not related_serializer_class:
                        data[field] = get_related_url(self.request, self.model, instance, '-'.join(field.split('_')), type='one')
                    else:
                        data[field] = self.serialize_related_object(related_serializer_class, instance, field, context=self.context)

        for field in self.many_related_fields:
            if not isinstance(data.get(field), list):
                related_serializer_class = self.many_related_serializer_class.get(field)
                if not related_serializer_class:
                    data[field] = get_related_url(self.request, self.model, instance, '-'.join(field.split('_')), type='many')
                else:
                    if isinstance(related_serializer_class, dict):
                        _context = {**related_serializer_class.get('context', {}), **self.context}
                        data[field] = self.serialize_related_object(related_serializer_class.get('serializer'), instance, field, many=True, context=_context)
                    else:
                        data[field] = self.serialize_related_object(related_serializer_class, instance, field, many=True, context=self.context)
        
        return data
