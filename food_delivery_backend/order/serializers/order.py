# order/serializers.py
from rest_framework import serializers
from order.models import Order, RestaurantCart, Promotion

from account.serializers import LocationSerializer
class OrderSerializer(serializers.ModelSerializer):
    delivery_address = LocationSerializer(read_only=True)
    
    class Meta:
        model = Order
        fields = ['id', 'cart', 'delivery_address', 'payment_method', 'promotion', 'delivery_fee', 
                  'discount', 'total', 'status', 'rating']
        read_only_fields = ['total']

    def to_representation(self, instance):
        data = super().to_representation(instance)
        from order.serializers import RestaurantCartSerializer2
        data['cart'] = RestaurantCartSerializer2(instance.cart).data
        return data

    # def create(self, validated_data):
    #     order = super().create(validated_data)
    #     order.calculate_total()  # Calculate total on creation
    #     return order

    # def update(self, instance, validated_data):
    #     instance.delivery_address = validated_data.get('delivery_address', instance.delivery_address)
    #     instance.payment_method = validated_data.get('payment_method', instance.payment_method)
    #     instance.promotion = validated_data.get('promotion', instance.promotion)
    #     instance.delivery_fee = validated_data.get('delivery_fee', instance.delivery_fee)
    #     instance.discount = validated_data.get('discount', instance.discount)
    #     instance.status = validated_data.get('status', instance.status)
    #     instance.calculate_total()  # Recalculate total on update
    #     instance.save()
    #     return instance

class CreateOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ['cart']
        
    def create(self, validated_data):
        cart = validated_data.pop('cart', None)
        
        order, created = Order.objects.get_or_create(cart=cart, defaults=validated_data)
        order.cart.is_created_order = True
        order.cart.save() 

        return order

    def to_representation(self, instance):
        from order.serializers import RestaurantCartSerializer2
        data = OrderSerializer(instance).data
        return data