from rest_framework import serializers

from restaurant.models import Restaurant

from restaurant.serializers import (
    BasicInfoSerializer, RepresentativeSerializer,
    DetailInfoSerializer, MenuDeliverySerializer
)
from order.serializers import (
    RestaurantPromotionSerializer
)

from review.serializers import RestaurantReviewSerializer

from utils.serializers import CustomRelatedModelSerializer

class RestaurantSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.one_related_serializer_class = {
            'basic_info': BasicInfoSerializer,
            'representative': RepresentativeSerializer,
            'detail_info': DetailInfoSerializer,
            'menu_delivery': MenuDeliverySerializer
        }
        self.many_related_serializer_class = {
            # 'owned_promotions': RestaurantPromotionSerializer,
            # 'user_reviews': RestaurantReviewSerializer
        }
    class Meta:
        model = Restaurant
        fields = [
            'id',
        ]
        depth = 2