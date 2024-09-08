# order/serializers.py
from rest_framework import serializers
from order.models import (
    Order, 
    OrderCancellation,
    RestaurantCart, 
    Promotion, 
)

from account.serializers import LocationSerializer
    
class OrderCancellationSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderCancellation
        fields = ['id', 'order', 'user', 'restaurant', 'reason', 'is_accepted', 'created_at', 'updated_at']
        read_only_fields = [
            'id', 
            'created_at',
            'updated_at'
        ]


class OrderSerializer(serializers.ModelSerializer):
    cancellation = OrderCancellationSerializer(read_only=True)
    delivery_address = LocationSerializer(read_only=True)
    
    class Meta:
        model = Order
        fields = ['id', 'cart', 'user', 'cancellation', 'delivery_address', 'payment_method', 'promotion', 'delivery_fee', 
                  'discount', 'total_price', 'total', 'status', 'rating']
        read_only_fields = ['total']

    def to_representation(self, instance):
        data = super().to_representation(instance)
        from order.serializers.basic import BasicRestaurantCartSerializer
        data['cart'] = BasicRestaurantCartSerializer(instance.cart).data
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
        request = self.context.get('request', None)
        delivery_address = None
        print(request.user, pretty=True)
        if request is not None and hasattr(request, 'user'):
            delivery_address = request.user.locations.filter(is_selected=True).first()
        
        print(delivery_address, pretty=True)
        
        order, created = Order.objects.get_or_create(cart=cart)
        order.cart.is_created_order = True
        if delivery_address:
            order.delivery_address = delivery_address
            order.save()

        order.cart.save() 
        print(order)
        return order

    def to_representation(self, instance):
        # if condition:
        from order.serializers import RestaurantCartSerializer2
        data = OrderSerializer(instance).data
        
        # from order.serializers import RestaurantCartSerializer
        # data = RestaurantCartSerializer(instance.cart).data

        return data
