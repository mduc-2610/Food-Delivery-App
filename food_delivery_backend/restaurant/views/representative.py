from rest_framework import viewsets, response, status

from restaurant.models import Representative

from restaurant.serializers import (
    RepresentativeSerializer,
    UpdateRepresentativeSerializer
)

from utils.views import OneRelatedViewSet

from utils.mixins import DefaultGenericMixin

class RepresentativeViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = Representative.objects.all()
    serializer_class = RepresentativeSerializer
    mapping_serializer_class = {
        'update': UpdateRepresentativeSerializer,
    }
    
    def create(self, request, *args, **kwargs):
        print(request.data, pretty=True)
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return response.Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)