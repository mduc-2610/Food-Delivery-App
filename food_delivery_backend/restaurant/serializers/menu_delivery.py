# menudelivery/serializers.py
from rest_framework import serializers
from restaurant.models import MenuDelivery

class BasicMenuDeliverySerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuDelivery
        fields = [
            'id', 
            'restaurant', 
            'menu_image',
        ]
        read_only_fields = ['id']

class MenuDeliverySerializer(BasicMenuDeliverySerializer):
    pass

class UpdateMenuDeliverySerializer(BasicMenuDeliverySerializer):
    class Meta(BasicMenuDeliverySerializer.Meta):
        read_only_fields = ['id', 'restaurant']