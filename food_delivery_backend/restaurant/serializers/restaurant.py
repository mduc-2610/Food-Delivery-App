from rest_framework import serializers

from food.models import DishCategory
from restaurant.models import (
    Restaurant,
    RestaurantCategory,
    RestaurantLike,
)

# from restaurant.serializers import (
#     BasicInfoSerializer, RepresentativeSerializer,
#     DetailInfoSerializer, MenuDeliverySerializer
# )

from restaurant.serializers.basic_info import BasicInfoSerializer
from restaurant.serializers.detail_info import DetailInfoSerializer
from restaurant.serializers.menu_delivery import MenuDeliverySerializer
from restaurant.serializers.representative_info import RepresentativeInfoSerializer
from restaurant.serializers.payment_info import PaymentInfoSerializer
# from order.serializers.owned_promotion import (
#     RestaurantPromotionSerializer
# )
from food.serializers import DishCategorySerializer, DishSerializer
from review.serializers import RestaurantReviewSerializer
from order.serializers.promotion import RestaurantPromotionSerializer

from utils.serializers import CustomRelatedModelSerializer
from utils.pagination import CustomPagination
from  utils.function import get_related_url_3


class RestaurantSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.many_related_serializer_class = {
            'dishes': DishSerializer
        }

    dishes = serializers.SerializerMethodField()
    distance_from_user = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()

    def get_dishes(self, obj):
        requrest = self.context.get('request', None)
        query_params = requrest.query_params if requrest else None
        category = query_params.get('category', None)

        queryset = obj.dishes.all() \
            if category is None \
            else obj.dishes.filter(category__name=category)
        
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

    def get_is_liked(self, obj):
        return obj.is_liked(
            request=self.context.get('request'),
        )

    class Meta:
        model = Restaurant
        fields = [
            'id', 
            'basic_info', 
            'distance_from_user', 
            'dishes', 
            'rating', 
            'total_reviews', 
            'total_likes',
            'avg_price',
            'is_certified',
            'is_liked',
        ]
        depth = 1
    
class DetailRestaurantSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.one_related_serializer_class = {
            'basic_info': BasicInfoSerializer,
            'detail_info': DetailInfoSerializer,
            'payment_info': PaymentInfoSerializer,
            'representative_info': RepresentativeInfoSerializer,
            'menu_delivery': MenuDeliverySerializer,
        }
        self.many_related_serializer_class = {
            # 'categories': {
            #     'serializer': DishCategorySerializer,
            #     'context': {'detail': True}
            # },
            
            # 'promotions': PromotionSerializer,
            # 'owned_promotions': RestaurantPromotionSerializer,
            # 'user_reviews': RestaurantReviewSerializer
        }

    distance_from_user = serializers.SerializerMethodField()
    stats = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()
    categories = serializers.SerializerMethodField()


    def get_distance_from_user(self, obj):
        request = self.context.get('request')
        if request and hasattr(request, 'user') and hasattr(request.user, 'locations'):
            user_location = request.user.locations.filter(is_selected=True).first()
            if user_location and hasattr(obj, 'basic_info'):
                return obj.basic_info.get_distance_from_user(user_location)
        return None
    
    def get_stats(self, obj):
        request = self.context.get('request')
        return get_related_url_3(
            request=request,
            obj=obj,
            action='stats',
            detail=True
        )

    def get_is_liked(self, obj):
        return obj.is_liked(
            request=self.context.get('request'),
        )

    def get_categories(self, obj):
        queryset = [x.category for x in obj.restaurant_categories.filter(is_disabled=False)]
        return DishCategorySerializer(queryset, many=True, context=self.context).data

    class Meta:
        model = Restaurant
        exclude = [
            'user', 
            # 'categories',
        ]


class CreateRestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = ['user',]
        read_only_fields = ['id',]

    def to_representation(self, instance):
        return DetailRestaurantSerializer(instance, context=self.context).data
    
class UpdateRestaurantSerializer(serializers.ModelSerializer):
    categories = serializers.ListField(
        child=serializers.UUIDField(),
        required=False,
    )
    disabled_categories = serializers.ListField(
        child=serializers.UUIDField(),
        required=False,
    )

    class Meta:
        model = Restaurant
        fields = [
            'categories',
            'disabled_categories',
        ]

    def update(self, instance, validated_data):
        restaurant = instance
        categories = validated_data.pop('categories', [])
        disabled_categories = validated_data.pop('disabled_categories', [])
        updated_categories = []
        updated_disabled_categories = []

        print('categories', categories, pretty=True)
        print('disabled_categories', disabled_categories, pretty=True)

        for _category in categories:
            _instance, _created = RestaurantCategory.objects.get_or_create(
                restaurant_id=restaurant.id,
                category_id=_category
            )
            _instance.is_disabled = False
            _instance.save()
            updated_categories.append(_instance)
        print(updated_categories, pretty=True)

        for _category in disabled_categories:
            _instance, _created = RestaurantCategory.objects.get_or_create(
                restaurant_id=restaurant.id,
                category_id=_category
            )
            _instance.is_disabled = True
            _instance.save()
            updated_disabled_categories.append(_instance)
        print(updated_disabled_categories, pretty=True)

        return super().update(instance, validated_data)

    def to_representation(self, instance):
        return DetailRestaurantSerializer(instance, context=self.context).data
    

class RestaurantCategorySerializer(serializers.ModelSerializer):
    category = serializers.SerializerMethodField(read_only=True)

    def get_category(self, obj):
        # context = self.context.update({
        #     'detail': False
        # })
        return DishCategorySerializer(obj.category, context=self.context).data
    
    class Meta:
        model = RestaurantCategory
        fields = '__all__'


class CreateUpdateRestaurantCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantCategory
        fields = [
            'id',
            'restaurant',
            'category',
            'created_at',
            'is_disabled',
        ]
        read_only_fields = ['id', 'created_at',]
    

class RestaurantLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantLike
        fields = "__all__"
        read_only_fields = ['id', 'created_at',]