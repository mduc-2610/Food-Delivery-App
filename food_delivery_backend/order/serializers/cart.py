# order/serializers.py
from rest_framework import serializers

from account.models import User
from order.models import RestaurantCart, RestaurantCartDish, Order
from restaurant.models import Restaurant
from restaurant.serializers.basic_restaurant import BasicRestaurantSerializer

from food.serializers import DishSerializer, DishOptionItemSerializer
from order.serializers.order import OrderSerializer

class RestaurantCartDishSerializer(serializers.ModelSerializer):
    dish = DishSerializer(read_only=True)
    options = serializers.ListSerializer(
        child=serializers.PrimaryKeyRelatedField(queryset=DishOptionItemSerializer.Meta.model.objects.all()),
        write_only=True,
        required=False,
    )
    chosen_options = DishOptionItemSerializer(read_only=True, many=True, source='options')

    class Meta:
        model = RestaurantCartDish
        fields = ['id', 'cart', 'dish', 'quantity', 'price', 'options', 'chosen_options']

    def update(self, instance, validated_data):
        options_data = validated_data.pop('options', [])
        instance = super().update(instance, validated_data)
        from order.models import ChosenDishOption
        instance.options.clear()
        chosen_options = [
            ChosenDishOption(restaurant_cart_dish=instance, option_item=option)
            for option in options_data
        ]
        ChosenDishOption.objects.bulk_create(chosen_options)

        return instance


class CreateRestaurantCartDishSerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantCartDish
        fields = ['cart', 'dish', 'quantity', 'price', 'discount_price']
        read_only_fields = ['price', 'discount_price']

    def create(self, validated_data):
        cart = validated_data.get('cart')
        dish = validated_data.get('dish')
        quantity = validated_data.get('quantity')
        
        if not cart:
            raise serializers.ValidationError("Cart is required.")
        
        if not dish:
            raise serializers.ValidationError("Dish is required.")
        
        if not quantity:
            raise serializers.ValidationError("Quantity is required.")
        
        try:
            cart_dish, created = RestaurantCartDish.objects.get_or_create(cart=cart, dish=dish)
            if not created:
                cart_dish.quantity += quantity
                if cart_dish.quantity <= 0:
                    cart_dish.quantity = 0
                    cart_dish.cart.is_empty = True
                    cart_dish.delete()
                else: cart_dish.save()
            elif quantity != 1: 
                cart_dish.quantity = quantity
                print(cart_dish.quantity, pretty=True)
            return cart_dish
        except Exception as e:
            raise serializers.ValidationError("Failed to create RestaurantCartDish.")

    def to_representation(self, instance):
        data = super().to_representation(instance)
        print(data, pretty=True)
        data['cart'] = RestaurantCartSerializer2(instance.cart).data
        return data

class RestaurantCartSerializer(serializers.ModelSerializer):
    dishes = RestaurantCartDishSerializer(many=True, read_only=True)  
    order = OrderSerializer(read_only=True)
    restaurant = BasicRestaurantSerializer(read_only=True)
    
    class Meta:
        model = RestaurantCart
        fields = ['id', 'user', 'restaurant', 'created_at', 'updated_at', 'total_price', 'total_items', 'dishes', 'order', 'is_created_order', 'is_empty']


class RestaurantCartSerializer2(serializers.ModelSerializer):
    dishes = RestaurantCartDishSerializer(many=True, read_only=True)  
    restaurant = BasicRestaurantSerializer(read_only=True)
    
    class Meta:
        model = RestaurantCart
        fields = ['id', 'user', 'restaurant', 'created_at', 'updated_at', 'total_price', 'total_items', 'dishes', 'is_created_order', 'is_empty']
        
class CreateRestaurantCartSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    restaurant = serializers.PrimaryKeyRelatedField(queryset=Restaurant.objects.all())

    class Meta:
        model = RestaurantCart
        fields = ['user', 'restaurant']

    def create(self, validated_data):
        user = validated_data.get('user')
        restaurant = validated_data.get('restaurant')
        
        if not user:
            raise serializers.ValidationError("User is required.")
        
        if not restaurant:
            raise serializers.ValidationError("Restaurant is required.")
        
        try:
            cart = RestaurantCart.objects.create(user=user, restaurant=restaurant)
            return cart
        except Exception as e:
            raise serializers.ValidationError("Failed to create RestaurantCart.")
        
    def to_representation(self, instance):
        return RestaurantCartSerializer(instance).data

