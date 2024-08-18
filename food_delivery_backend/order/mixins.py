from django.db import models
from rest_framework.exceptions import NotFound

class OrderFilterMixin:
    def get_object(self):
        pk = self.kwargs.get('pk', None)
        model = self.queryset.model
        params = self.request.query_params

        if hasattr(self, 'action') and self.action == 'restaurant_carts':
            try:
                instance = model.objects.get(pk=pk)
            except self.queryset.model.DoesNotExist:
                raise NotFound('Instance not found')
            
            def _queryset(instance):
                return self.many_related[self.action]['queryset'](instance)
            
            star_filter = params.get('star_filter', None)
            if star_filter is not None:
                try: 
                    star_filter = int(star_filter)
                except:
                    star_filter = star_filter.upper()
                
            if star_filter:
                if isinstance(star_filter, str):
                    if star_filter == "ALL":
                        return _queryset(instance)
                    return  _queryset(instance) \
                        .filter(order__status=star_filter)
                elif isinstance(star_filter, int):
                    if 1 <= star_filter <= 5:
                        return _queryset(instance) \
                            .filter(order__rating=star_filter)
                    else:
                        return []
        return super().get_object()
