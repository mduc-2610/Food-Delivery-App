# delivery/serializers.py
from rest_framework import serializers
from order.models import Delivery

class DeliverySerializer(serializers.ModelSerializer):
    class Meta:
        model = Delivery
        fields = ['id', 'order', 'deliverer', 'pickup_location', 'pickup_lat', 'pickup_long', 
                  'dropoff_location', 'dropoff_lat', 'dropoff_long', 'status', 
                  'estimated_delivery_time', 'actual_delivery_time', 'created_at', 'updated_at']
        read_only_fields = ['created_at', 'updated_at']
