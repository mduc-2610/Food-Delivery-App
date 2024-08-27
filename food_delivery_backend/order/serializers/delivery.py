# delivery/serializers.py
from rest_framework import serializers
from order.models import Delivery

from order.serializers.order import OrderSerializer

class DeliverySerializer(serializers.ModelSerializer):
    order = OrderSerializer(read_only=True)
    class Meta:
        model = Delivery
        fields = "__all__"
        read_only_fields = ['created_at', 'updated_at']
