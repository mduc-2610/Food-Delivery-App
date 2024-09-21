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
from restaurant.serializers.payment_info import PaymentInfoSerializer
from order.serializers.owned_promotion import (
    RestaurantPromotionSerializer
)
from food.serializers import DishCategorySerializer, DishSerializer
from review.serializers import RestaurantReviewSerializer
from order.serializers.promotion import PromotionSerializer

from utils.serializers import CustomRelatedModelSerializer
from utils.pagination import CustomPagination

class RestaurantSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.many_related_serializer_class = {
            'dishes': DishSerializer
        }

    dishes = serializers.SerializerMethodField()
    distance_from_user = serializers.SerializerMethodField()

    def get_dishes(self, obj):
        queryset = obj.dishes.all()
        paginator = CustomPagination(page_size_query_param='dish_page_size', page_query_param='dish_page')
        request = self.context.get('request')
        page = paginator.paginate_queryset(queryset, request)

        return DishSerializer(page, many=True, context=self.context).data

    def get_distance_from_user(self, obj):
        request = self.context.get('request')
        if request and hasattr(request, 'user') and hasattr(request.user, 'locations'):
            user_location = request.user.locations.filter(is_selected=True).first()
            if user_location:
                return obj.basic_info.get_distance_from_user(user_location)
        return None

    class Meta:
        model = Restaurant
        fields = [
            'id', 'basic_info', 'distance_from_user', 'dishes', 'rating', 'total_reviews', 'avg_price'
        ]
        depth = 1
    
class DetailRestaurantSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.one_related_serializer_class = {
            'basic_info': BasicInfoSerializer,
            'detail_info': DetailInfoSerializer,
            'payment_info': PaymentInfoSerializer,
            'representative': RepresentativeSerializer,
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
    distance_from_user = serializers.SerializerMethodField()

    def get_distance_from_user(self, obj):
        request = self.context.get('request')
        if request and hasattr(request, 'user') and hasattr(request.user, 'locations'):
            user_location = request.user.locations.filter(is_selected=True).first()
            if user_location and hasattr(obj, 'basic_info'):
                return obj.basic_info.get_distance_from_user(user_location)
        return None
    
    class Meta:
        model = Restaurant
        exclude = [
            'user', 
            'promotions', 
            'categories',
        ]


class CreateRestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = ['user',]
        read_only_fields = ['id',]

    def to_representation(self, instance):
        return DetailRestaurantSerializer(instance, context=self.context).data

class RestaurantCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantCategory
        fields = '__all__'
