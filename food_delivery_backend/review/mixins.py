from django.db import models
from rest_framework.exceptions import NotFound

class ReviewFilterMixin:
    def get_object(self):
        pk = self.kwargs.get('pk', None)
        model = self.queryset.model
        params = self.request.query_params
        filter_kwargs = {}
        
        for field in self.get_serializer_class().Meta.model._meta.get_fields():
            if isinstance(field, models.ForeignKey) and params.get(field.name):
                filter_kwargs[f'{field.name}__id'] = params.get(field.name)

        if self.action in self.many_related:
            try:
                instance = model.objects.get(pk=pk)
            except self.queryset.model.DoesNotExist:
                raise NotFound('Instance not found')
            
            def _queryset(instance, filter_kwargs):
                if filter_kwargs:
                    return self.many_related[self.action]['queryset'](instance).filter(**filter_kwargs)
                else:
                    return self.many_related[self.action]['queryset'](instance)
            
            star_filter = params.get('star_filter', None)
            if star_filter is not None:
                try: 
                    star_filter = int(star_filter)
                except:
                    star_filter = star_filter
            if star_filter:
                if star_filter == 'positive':
                    return _queryset(instance, filter_kwargs) \
                        .filter(rating__gte=3)
                elif star_filter == 'negative':
                    return _queryset(instance, filter_kwargs) \
                        .filter(rating__lte=2)
                else:
                    if 1 <= star_filter <= 5:
                        return _queryset(instance, filter_kwargs) \
                            .filter(rating=star_filter)       
                    return []
            else:
                return _queryset(instance, filter_kwargs)
            
        return super().get_object()
