from rest_framework import viewsets, response, status

from restaurant.models import RepresentativeInfo

from restaurant.serializers import (
    RepresentativeInfoSerializer,
    UpdateRepresentativeInfoSerializer
)

from utils.views import OneRelatedViewSet

from utils.mixins import DefaultGenericMixin

class RepresentativeViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = RepresentativeInfo.objects.all()
    serializer_class = RepresentativeInfoSerializer
    mapping_serializer_class = {
        'update': UpdateRepresentativeInfoSerializer,
    }
    