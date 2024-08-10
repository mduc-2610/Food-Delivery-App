# order/views.py
from rest_framework import viewsets

from order.models import Order

from order.serializers import OrderSerializer

from utils.mixins import DefaultGenericMixin

class OrderViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    def perform_create(self, serializer):
        instance = serializer.save()
        instance.calculate_total()  
