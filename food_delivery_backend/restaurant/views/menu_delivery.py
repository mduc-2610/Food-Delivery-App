from rest_framework import viewsets

from restaurant.models import MenuDelivery

from restaurant.serializers import (
    MenuDeliverySerializer,
    UpdateMenuDeliverySerializer,
)

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class MenuDeliveryViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = MenuDelivery.objects.all()
    serializer_class = MenuDeliverySerializer
    mapping_serializer_class = {
        'update': UpdateMenuDeliverySerializer,
    }