from django.db import models
from rest_framework.exceptions import NotFound

class OrderFilterMixin:
    def get_object(self):
        pk = self.kwargs.get('pk', None)
        model = self.queryset.model
        params = self.request.query_params

        if hasattr(self, 'action') and \
            (self.action == 'restaurant_carts' or self.action == 'orders'):
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
            filter_kwargs = {}
            if self.action == 'restaurant_carts':
                filter_kwargs['order__delivery'] = None
            if star_filter:
                if isinstance(star_filter, str):
                    if star_filter == "ALL":
                        return _queryset(instance)
                    filter_kwargs[f"{'order__status' if self.action == 'restaurant_carts' else 'status'}"] = star_filter
                elif isinstance(star_filter, int):
                    if 1 <= star_filter <= 5:
                        filter_kwargs[f"{'order__rating' if self.action == 'restaurant_carts' else 'rating'}"] = star_filter
                    else:
                        return []
            return _queryset(instance).filter(**filter_kwargs)
        return super().get_object()
