# restaurant/serializers.py
from rest_framework import serializers
from restaurant.models import Restaurant

class RestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = [
            'id', 'user', 'basic_info', 'representative', 'detail_information', 
            'menu_delivery', 'promotions'
        ]
        depth = 2  # Adjust depth based on your relationships if needed
