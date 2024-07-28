from rest_framework import serializers

from restaurant.models import Restaurant

# from restaurant.serializers import (
#     BasicInfoSerializer, RepresentativeSerializer,
#     DetailInfoSerializer, MenuDeliverySerializer
# )

from restaurant.serializers.basic_info import BasicInfoSerializer
from restaurant.serializers.detail_info import DetailInfoSerializer
from restaurant.serializers.menu_delivery import MenuDeliverySerializer
from restaurant.serializers.representative import RepresentativeSerializer

from order.serializers import (
    RestaurantPromotionSerializer
)

from review.serializers import RestaurantReviewSerializer

from utils.serializers import CustomRelatedModelSerializer

class RestaurantSerializer(CustomRelatedModelSerializer):
    
    class Meta:
        model = Restaurant
        fields = [
            'id', 'basic_info'
        ]
        depth = 2
    
class DetailRestaurantSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.one_related_serializer_class = {
            'basic_info': BasicInfoSerializer,
            'representative': RepresentativeSerializer,
            'detail_info': DetailInfoSerializer,
            'menu_delivery': MenuDeliverySerializer
        }
        from order.serializers import PromotionSerializer
        self.many_related_serializer_class = {
            
            # 'promotions': PromotionSerializer,
            # 'owned_promotions': RestaurantPromotionSerializer,
            # 'user_reviews': RestaurantReviewSerializer
        }
    
    class Meta:
        model = Restaurant
        exclude = ['user']
    