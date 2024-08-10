

class DefaultGenericMixin:
    def get_serializer_class(self):
        if hasattr(self, 'mapping_serializer_class') \
            and self.mapping_serializer_class.get(self.action):
            return self.mapping_serializer_class[self.action]
        return super().get_serializer_class()
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == 'list':
            context.update({
                'detail': False
            })
        return context