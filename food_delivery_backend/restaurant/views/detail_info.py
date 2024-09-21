from rest_framework import viewsets

from restaurant.models import DetailInfo

from restaurant.serializers import (
    DetailInfoSerializer,
    UpdateDetailInfoSerializer,
)

from utils.views import OneRelatedViewSet

from utils.mixins import DefaultGenericMixin

class DetailInfoViewSet(DefaultGenericMixin,OneRelatedViewSet):
    queryset = DetailInfo.objects.all()
    serializer_class = DetailInfoSerializer
    mapping_serializer_class = {
        'update': UpdateDetailInfoSerializer,
    }
