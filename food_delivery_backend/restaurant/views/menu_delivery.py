from rest_framework import viewsets

from restaurant.models import MenuDelivery

from restaurant.serializers import MenuDeliverySerializer

from utils.views import OneToOneViewSet

class MenuDeliveryViewSet(OneToOneViewSet):
    queryset = MenuDelivery.objects.all()
    serializer_class = MenuDeliverySerializer
