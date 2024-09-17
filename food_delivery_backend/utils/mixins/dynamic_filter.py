import re
from datetime import datetime
from django.db.models import Q
from django.db.models.fields import CharField, IntegerField, DateField, DecimalField, BooleanField
from rest_framework.exceptions import ValidationError

class DynamicFilterMixin:
    
    def filter_queryset(self, queryset):
        query_params = self.request.query_params
        model_fields = queryset.model._meta.fields
        filter_kwargs = Q()

        for field in model_fields:
            field_name = field.name
            field_param = query_params.get(field_name)
            field_param_less = query_params.get(f"{field_name}_less")
            field_param_bigger = query_params.get(f"{field_name}_bigger")

            if field_param:
                if isinstance(field, CharField):
                    if field.choices:
                        formatted_value = re.sub(r'\W+', '_', field_param.strip()).upper()
                        valid_choices = dict(field.choices)
                        if formatted_value in valid_choices:
                            filter_kwargs &= Q(**{field_name: valid_choices[formatted_value]})
                        else:
                            raise ValidationError({field_name: f"Must be one of: {', '.join([choice[0] for choice in field.choices])}"})
                    else:
                        filter_kwargs &= Q(**{f"{field_name}__icontains": field_param})

                elif isinstance(field, IntegerField):
                    try:
                        filter_kwargs &= Q(**{field_name: int(field_param)})
                    except ValueError:
                        raise ValidationError({field_name: "Must be a valid integer."})

                elif isinstance(field, DateField):
                    try:
                        field_param = datetime.strptime(field, '%Y-%m-%d').date()
                        start_of_day = datetime.combine(field_param, datetime.min.time())
                        end_of_day = datetime.combine(field_param, datetime.max.time())
                        filter_kwargs &= Q(**{f"{field_param}__range": (start_of_day, end_of_day)})
                    except ValueError:
                        raise ValidationError({field_name: "Must be a valid date."})

                elif isinstance(field, DecimalField):
                    try:
                        if field_param_less:
                            filter_kwargs &= Q(**{f"{field_name}__lte": float(field_param_less)})
                        if field_param_bigger:
                            filter_kwargs &= Q(**{f"{field_name}__gte": float(field_param_bigger)})
                    except ValueError:
                        raise ValidationError({field_name: "Must be a valid decimal."})

                elif isinstance(field, BooleanField):
                    if field_param.lower() in ['true', '1']:
                        filter_kwargs &= Q(**{field_name: True})
                    elif field_param.lower() in ['false', '0']:
                        filter_kwargs &= Q(**{field_name: False})
                    else:
                        raise ValidationError({field_name: "Must be 'true', 'false', '1', or '0'."})

        return queryset.filter(filter_kwargs)
