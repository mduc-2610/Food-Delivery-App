# delivery/serializers.py
from rest_framework import serializers
from order.models import Delivery

class DeliverySerializer(serializers.ModelSerializer):
    class Meta:
        model = Delivery
        fields = "__all__"
        read_only_fields = ['created_at', 'updated_at']
