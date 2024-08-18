# order/serializers.py
from rest_framework import serializers

from order.models import RestaurantCart, RestaurantCartDish
from restaurant.models import Restaurant

from food.serializers import DishSerializer
from order.serializers.order import OrderSerializer

class RestaurantCartDishSerializer(serializers.ModelSerializer):
    dish = DishSerializer(read_only=True)  
    
    class Meta:
        model = RestaurantCartDish
        fields = ['id', 'cart', 'dish', 'quantity', 'price']


class BasicRestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = [
            'id', 'basic_info', 'rating', 'total_reviews', 'avg_price'
        ]
        depth = 1

class RestaurantCartSerializer(serializers.ModelSerializer):
    dishes = RestaurantCartDishSerializer(many=True, read_only=True)  
    order = OrderSerializer(read_only=True)
    restaurant = BasicRestaurantSerializer(read_only=True)
    
    class Meta:
        model = RestaurantCart
        fields = ['id', 'user', 'restaurant', 'created_at', 'updated_at', 'is_placed_order', 'raw_fee', 'dishes', 'order']
