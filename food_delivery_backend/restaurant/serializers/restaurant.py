from rest_framework import serializers

from restaurant.models import Restaurant, RestaurantCategory

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
from food.serializers import DishCategorySerializer
from review.serializers import RestaurantReviewSerializer
from order.serializers import PromotionSerializer

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
            'menu_delivery': MenuDeliverySerializer,
        }
        self.many_related_serializer_class = {
            # 'categories': {
            #     'serializer': DishCategorySerializer,
            #     'context': {'detail': False}
            # },
            
            # 'promotions': PromotionSerializer,
            # 'owned_promotions': RestaurantPromotionSerializer,
            # 'user_reviews': RestaurantReviewSerializer
        }
    
    categories = DishCategorySerializer(many=True)
    class Meta:
        model = Restaurant
        exclude = ['user', 'promotions']

class RestaurantCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantCategory
        fields = '__all__'
