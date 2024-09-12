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
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == 'list':
            context.update({'detail': False})
        return context
