from rest_framework import serializers


from order.models import (
    Order,
    RestaurantCart,
)

from account.serializers import UserLocationSerializer
from order.serializers.cart import RestaurantCartDishSerializer
from restaurant.serializers import BasicRestaurantSerializer

class BasicOrderSerializer(serializers.ModelSerializer):
    delivery_address = UserLocationSerializer(read_only=True)

    class Meta:
        model = Order
        fields = [
            'id', 
            'cart', 
            'user', 
            'delivery_address', 
            'payment_method', 
            'delivery_fee', 
            'discount', 
            'total_price', 
            'total', 
            'status', 
            'rating'
        ]
        read_only_fields = ['total']

class BasicRestaurantCartSerializer(serializers.ModelSerializer):
    dishes = RestaurantCartDishSerializer(many=True, read_only=True)  
    restaurant = BasicRestaurantSerializer(read_only=True)
    
    class Meta:
        model = RestaurantCart
        fields = [
            'id', 
            'user', 
            'restaurant', 
            'created_at', 
            'updated_at', 
            'total_price', 
            'total_items', 
            'dishes', 
            'is_created_order', 
            'is_empty'
        ]
