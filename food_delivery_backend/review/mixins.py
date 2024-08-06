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
            
            if filter_kwargs:
                queryset = self.many_related[self.action]['queryset'](instance).filter(**filter_kwargs)
            else:
                queryset = self.many_related[self.action]['queryset'](instance)
            
            star_filter = params.get('star_filter', None)
            if star_filter:
                if star_filter == 'positive':
                    queryset = queryset.filter(rating__gte=3)
                elif star_filter == 'negative':
                    queryset = queryset.filter(rating__lte=2)
                else:
                    try:
                        star_value = int(star_filter)
                        if 1 <= star_value <= 5:
                            queryset = queryset.filter(rating=star_value)
                    except ValueError:
                        pass 
            
            return queryset
        
        return super().get_object()
