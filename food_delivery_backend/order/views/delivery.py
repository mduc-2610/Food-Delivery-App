# delivery/views.py
from rest_framework import viewsets
from order.models import Delivery
from order.serializers import DeliverySerializer

class DeliveryViewSet(viewsets.ModelViewSet):
    queryset = Delivery.objects.all()
    serializer_class = DeliverySerializer
