from rest_framework import viewsets

from restaurant.models import MenuDelivery

from restaurant.serializers import MenuDeliverySerializer

from utils.views import OneRelatedViewSet

class MenuDeliveryViewSet(OneRelatedViewSet):
    queryset = MenuDelivery.objects.all()
    serializer_class = MenuDeliverySerializer
