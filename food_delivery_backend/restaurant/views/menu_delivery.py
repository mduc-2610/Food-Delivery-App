# menudelivery/views.py
from rest_framework import viewsets
from restaurant.models import MenuDelivery
from restaurant.serializers import MenuDeliverySerializer

class MenuDeliveryViewSet(viewsets.ModelViewSet):
    queryset = MenuDelivery.objects.all()
    serializer_class = MenuDeliverySerializer
