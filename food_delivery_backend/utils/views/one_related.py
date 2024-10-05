import uuid
from django.db import models
from django.db.models import Q
from rest_framework import viewsets, exceptions
import uuid

class OneRelatedViewSet(viewsets.ModelViewSet):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.model = self.queryset.model
        self.related_attribute = self.get_related_model().name

    def get_object(self):
        if not hasattr(self, 'related_attribute'):
            self.model = self.queryset.model
            self.related_attribute =  [field for field in self.model._meta.get_fields() if isinstance(field, models.OneToOneField)][0]
            self.related_attribute = self.related_attribute.name if hasattr(self.related_attribute, 'name') else None

        pk = self.kwargs.get('pk')
        if pk is None:
            raise exceptions.NotFound('Primary key not provided')

        filter_kwargs = Q(**{f"{self.related_attribute}__id": pk})

        try:
            pk = int(pk)
            is_integer = True
        except ValueError:
            is_integer = False
        if not is_integer:
            try:
                uuid_obj = uuid.UUID(pk, version=4)
                filter_kwargs |= Q(id=uuid_obj)
            except ValueError:
                filter_kwargs |= Q(id=pk)

        try:
            return self.model.objects.get(filter_kwargs)
        except self.model.DoesNotExist:
            raise exceptions.NotFound(f'{self.model.__name__} not found')
        except exceptions.ValidationError:
            raise exceptions.NotFound(f'Invalid lookup parameters')
        
    def get_related_model(self):
        for field in self.model._meta.get_fields():
            if isinstance(field, models.OneToOneField):
                return field
        raise exceptions.NotFound('Related model not found')
