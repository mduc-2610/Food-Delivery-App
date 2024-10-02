from rest_framework import serializers
from order.models import (
    Delivery,
    DeliveryRequest,
)

from account.serializers.basic_user import BasicUserSerializer
from restaurant.serializers.basic_restaurant import BasicRestaurantSerializer
from deliverer.serializers.basic_deliverer import BasicDelivererSerializer
from order.serializers.order import OrderSerializer
from utils.serializers import CustomRelatedModelSerializer
from utils.function import camel_to_snake


class DeliverySerializer(CustomRelatedModelSerializer):
    order = OrderSerializer(read_only=True)
    user = BasicUserSerializer(read_only=True)
    restaurant = BasicRestaurantSerializer(read_only=True)
    # deliverer = BasicDelivererSerializer(read_only=True)

    class Meta:
        model = Delivery
        fields = "__all__"
        read_only_fields = ['created_at', 'updated_at']


class DeliveryRequestSerializer(serializers.ModelSerializer):
    delivery = serializers.SerializerMethodField()
    user = BasicUserSerializer(read_only=True)
    # deliverer = BasicDelivererSerializer(read_only=True)
    accept = serializers.SerializerMethodField()
    decline = serializers.SerializerMethodField()
    complete = serializers.SerializerMethodField()

    def get_delivery(self, obj):
        if hasattr(obj, 'delivery'):
            return DeliverySerializer(obj.delivery, context=self.context).data
        return None

    def build_uri(self, action, obj):
        request = self.context.get('request')
        if request:
            return request.build_absolute_uri(
                f'/api/{obj._meta.app_label}/{camel_to_snake(obj._meta.model.__name__)}/{obj.id}/{action}'
            )
        return None

    def get_accept(self, obj):
        return self.build_uri('accept', obj)

    def get_decline(self, obj):
        return self.build_uri('decline', obj)
    
    def get_complete(self, obj):
        return self.build_uri('complete', obj)
    
    class Meta:
        model = DeliveryRequest
        fields = "__all__"
        read_only_fields = (
            'id',
            'expired_at',
            'responded_at',
        )