from django.db.models import OneToOneField

from rest_framework import viewsets, exceptions

class OneRelatedViewSet(viewsets.ModelViewSet):
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
            if isinstance(field, OneToOneField):
                return field
        raise exceptions.NotFound('Related model not found')