import re
from datetime import datetime
import unidecode

from django.db.models import Q, OneToOneField
from django.db import models

from rest_framework.exceptions import ValidationError

def _normalize_text(text):
    return unidecode.unidecode(text) if text is not None and isinstance(text, str) else text

class DynamicFilterMixin:
    def filter_queryset(self, queryset):
        query_params = self.request.query_params
        model = queryset.model
        model_fields = model._meta.get_fields()
        filter_kwargs = Q()
        
        def _process_fields(fields, prefix=''):
            nonlocal filter_kwargs
            for field in fields:
                field_name = field.name
                full_field_name = f"{prefix}{field_name}" if prefix else field_name
                field_param = query_params.get(full_field_name)
                field_param_less = query_params.get(f"{full_field_name}_less")
                field_param_bigger = query_params.get(f"{full_field_name}_bigger")
                
                if isinstance(field, models.OneToOneRel):
                    related_model = field.related_model
                    related_fields = related_model._meta.get_fields()
                    new_prefix = f"{full_field_name}__"
                    _process_fields(related_fields, prefix=new_prefix)
                    continue

                if field_param or field_param_less or field_param_bigger:   
                    try:
                        if isinstance(field, (models.CharField, models.UUIDField)):
                            if field_param:
                                if field.choices:
                                    formatted_value = re.sub(r'\W+', '_', field_param.strip()).upper()
                                    valid_choices = dict(field.choices)
                                    if formatted_value in valid_choices:
                                        filter_kwargs &= Q(**{full_field_name: valid_choices[formatted_value]})
                                    else:
                                        raise ValidationError({
                                            full_field_name: f"Must be one of: {', '.join([choice[0] for choice in field.choices])}"
                                        })
                                else:
                                    filter_kwargs &= Q(**{f"{full_field_name}__icontains": field_param})

                        elif isinstance(field, models.IntegerField):
                            if field_param:
                                filter_kwargs &= Q(**{full_field_name: int(field_param)})
                            if field_param_less:
                                filter_kwargs &= Q(**{f"{full_field_name}__lte": int(field_param_less)})
                            if field_param_bigger:
                                filter_kwargs &= Q(**{f"{full_field_name}__gte": int(field_param_bigger)})

                        elif isinstance(field, models.DateField):
                            if field_param:
                                date_value = datetime.strptime(field_param, '%Y-%m-%d').date()
                                start_of_day = datetime.combine(date_value, datetime.min.time())
                                end_of_day = datetime.combine(date_value, datetime.max.time())
                                filter_kwargs &= Q(**{f"{full_field_name}__range": (start_of_day, end_of_day)})

                        elif isinstance(field, models.DecimalField):
                            if field_param_less:
                                filter_kwargs &= Q(**{f"{full_field_name}__lte": float(field_param_less)})
                            if field_param_bigger:
                                filter_kwargs &= Q(**{f"{full_field_name}__gte": float(field_param_bigger)})
                            if field_param:
                                filter_kwargs &= Q(**{full_field_name: float(field_param)})

                        elif isinstance(field, models.BooleanField):
                            if field_param:
                                val = field_param.lower()
                                if val in ['true', '1']:
                                    filter_kwargs &= Q(**{full_field_name: True})
                                elif val in ['false', '0']:
                                    filter_kwargs &= Q(**{full_field_name: False})
                                else:
                                    raise ValidationError({
                                        full_field_name: "Must be 'true', 'false', '1', or '0'."
                                    })

                    except ValueError:
                        raise ValidationError({
                            full_field_name: f"Invalid value for field '{full_field_name}'."
                        })
                    

        _process_fields(model_fields)
        return queryset.filter(filter_kwargs)

"""
1. modify this to make it recursive on the field is OneToOneField (one more depth filter)
2. get field from models not exactly right because 
    if user.objects.all() it will be user that will be true
    else user.restaurants.all() it should be restaurant
3. that wont work because the first condition will always true
    the solution i come up with is the first element of the queryset but if the queryset return none it will not true
4. user and restaurant is one to one but one to one put to restaurant is user
    basic_info and restaurant is one to one but one to one is put to basic_info 
    i am now working with restaurant and i want one to one field like basic_info feature not user 
5. user and restaurant is one to one but one to one put to restaurant is user
    basic_info and restaurant is one to one but one to one is put to basic_info 
    i am now working with restaurant and i want one to one field like basic_info feature not user 
    modify my OneToOneField condition
"""