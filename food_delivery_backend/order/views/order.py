# order/views.py
from rest_framework import viewsets
from order.models import Order
from order.serializers import OrderSerializer

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    def perform_create(self, serializer):
        instance = serializer.save()
        instance.calculate_total()  
