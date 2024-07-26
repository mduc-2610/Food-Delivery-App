from rest_framework import viewsets, exceptions

class OneToOneViewSet(viewsets.ModelViewSet):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.model = self.queryset.model
        self.related_attribute = self.get_related_model().name

    def get_object(self):
        pk = self.kwargs.get('pk')
        if pk is None:
            raise exceptions.NotFound('Primary key not provided')
        filter_kwargs = {f"{self.related_attribute}__id": pk}
        try:
            return self.model.objects.get(**filter_kwargs)
        except self.model.DoesNotExist:
            raise exceptions.NotFound(f'{self.model.__name__} not found')

    def get_related_model(self):
        for field in self.model._meta.get_fields():
            if field.one_to_one:
                return field
        raise exceptions.NotFound('Related model not found')
    
    def get_serializer_context(self):
        return super().get_serializer_context()