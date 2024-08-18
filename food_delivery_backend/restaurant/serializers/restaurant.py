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
from food.serializers import DishCategorySerializer, DishSerializer
from review.serializers import RestaurantReviewSerializer
from order.serializers import PromotionSerializer

from utils.serializers import CustomRelatedModelSerializer
from utils.pagination import CustomPagination

class RestaurantSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.many_related_serializer_class = {
            'dishes': DishSerializer
        }

    dishes = serializers.SerializerMethodField()
    def get_dishes(self, obj):
        queryset = obj.dishes.all()
        paginator = CustomPagination(page_size_query_param='dish_page_size', page_query_param='dish_page')
        request = self.context.get('request')
        page = paginator.paginate_queryset(queryset, request)

        return DishSerializer(page, many=True, context=self.context).data


    class Meta:
        model = Restaurant
        fields = [
            'id', 'basic_info', 'dishes', 'rating', 'total_reviews', 'avg_price'
        ]
        depth = 1
    
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
            'categories': {
                'serializer': DishCategorySerializer,
                'context': {'detail': True}
            },
            
            # 'promotions': PromotionSerializer,
            # 'owned_promotions': RestaurantPromotionSerializer,
            # 'user_reviews': RestaurantReviewSerializer
        }
    
    class Meta:
        model = Restaurant
        exclude = ['user', 'promotions', 'categories']

class RestaurantCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantCategory
        fields = '__all__'
