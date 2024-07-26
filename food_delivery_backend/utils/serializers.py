from rest_framework import serializers
from utils.function import get_many_related_url, get_one_related_url
from django.apps import apps

class CustomRelatedModelSerializer(serializers.ModelSerializer):
    _initialized = False

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.many = self.context.get('many', False)
        self.request = self.context.get('request')
        self.query_params = self.request.query_params
        self.separator = self.query_params.get('separator', ',')
        self.model = self.Meta.model

        self.one_related_fields = []
        self.many_related_fields = []

        self.one_related_exclude_fields = self.get_list_param('one_related_exclude_fields', separator=self.separator)
        self.many_related_exclude_fields = self.get_list_param('many_related_exclude_fields', separator=self.separator)

        if not self.many:
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
        print(self.many_related_fields)


    def get_list_param(self, param_name, default='', separator=','):
        param_value = self.query_params.get(param_name, default)
        if param_value:
            return [field.strip() for field in param_value.split(separator) if field.strip()]
        return []

    def serialize_related_object(self, related_serializer_class, obj, related, many=False):
        if self.request and not self.many:
            related_obj = getattr(obj, related, None)
            if related_obj:
                related_serializer = related_serializer_class(related_obj, many=many, context=self.context)
                return related_serializer.data
        return None

    def to_representation(self, instance):
        data = super().to_representation(instance)
        for field in self.one_related_fields:   
            if not isinstance(data.get(field), dict):
                related_serializer_class = self.one_related_serializer_class.get(field)
                if not related_serializer_class:
                    data[field] = get_one_related_url(self.request, self.many, instance, '-'.join(field.split('_')))
                else:
                    data[field] = self.serialize_related_object(related_serializer_class, instance, field)
            
        for field in self.many_related_fields:
            if not isinstance(data.get(field), list):
                related_serializer_class = self.many_related_serializer_class.get(field)
                if not related_serializer_class:
                    data[field] = get_many_related_url(self.request, self.many, instance, '-'.join(field.split('_')))
                else:
                    data[field] = self.serialize_related_object(related_serializer_class, instance, field, many=True)
        
        return data

