# order/serializers.py
from rest_framework import serializers
from order.models import Cart, RestaurantCart, RestaurantCartDish
from food.serializers import DishSerializer

class RestaurantCartDishSerializer(serializers.ModelSerializer):
    dish = DishSerializer()  
    
    class Meta:
        model = RestaurantCartDish
        fields = ['id', 'cart', 'dish', 'quantity', 'price']

class RestaurantCartSerializer(serializers.ModelSerializer):
    dishes = RestaurantCartDishSerializer(many=True, read_only=True)  
    
    class Meta:
        model = RestaurantCart
        fields = ['id', 'cart', 'restaurant', 'created_at', 'updated_at', 'is_placed_order', 'raw_fee', 'dishes']

class CartSerializer(serializers.ModelSerializer):
    restaurant_carts = RestaurantCartSerializer(many=True, read_only=True)  
    
    class Meta:
        model = Cart
        fields = ['user', 'created_at', 'updated_at', 'restaurant_carts']
