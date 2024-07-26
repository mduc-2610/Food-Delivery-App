# menudelivery/serializers.py
from rest_framework import serializers
from restaurant.models import MenuDelivery

class MenuDeliverySerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuDelivery
        fields = ['id', 'restaurant', 'menu_image']
