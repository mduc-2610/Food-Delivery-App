# your_app/mixins.py

from django.db.models import ForeignKey
from rest_framework import exceptions

class ForeignKeyFilterMixin:

    def get_queryset(self):
        queryset = super().get_queryset()
        model = queryset.model
        fk_fields = [
            field.name for field in model._meta.get_fields()
            if isinstance(field, ForeignKey)
        ]

        filter_kwargs = {}

        for fk in fk_fields:
            value = self.request.query_params.get(fk, None)
            if value is not None:
                filter_kwargs[fk] = value

        if filter_kwargs:
            queryset = queryset.filter(**filter_kwargs)
            first_element = queryset.first()
            if first_element:
                return queryset.filter(pk=first_element.pk)
            else:
                return []
        return queryset