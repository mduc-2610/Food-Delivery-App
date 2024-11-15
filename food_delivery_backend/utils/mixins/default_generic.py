from rest_framework import response

class DefaultGenericMixin:
    def get_serializer_class(self):
        if hasattr(self, 'mapping_serializer_class'):
            for actions, serializer_class in self.mapping_serializer_class.items():
                if isinstance(actions, (list, tuple)):
                    if self.action in actions:
                        return serializer_class
                elif actions == self.action:
                    return serializer_class
        return super().get_serializer_class()
    
    def paginate_queryset(self, queryset):
        can_paginate = self.request.query_params.get('can_paginate', None)
        if can_paginate is None:
            can_paginate = True
        else:
            can_paginate = can_paginate.lower() in ('true', '1') if can_paginate else False
            
        if can_paginate:
            return super().paginate_queryset(queryset)
        return None

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == 'list':
            context.update({'detail': False})
        return context
