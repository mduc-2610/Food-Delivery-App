from rest_framework import serializers

from food.models import (
    Dish,
    DishImage,
    DishLike,
)

from account.serializers import UserSerializer
from food.serializers.category import DishCategorySerializer
from food.serializers.option import DishOptionSerializer
from food.serializers.dish_like import DishLikeSerializer
from review.serializers import DishReviewSerializer

from utils.function import update_attr
from utils.serializers import CustomRelatedModelSerializer

class DishImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishImage
        fields = "__all__"
        read_only_fields = ['id']

class DishSerializer(serializers.ModelSerializer):
    images = DishImageSerializer(many=True, read_only=True)
    category = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()

    def get_category(self, obj):
        if hasattr(obj, 'category'):
            return DishCategorySerializer(obj.category, context={
                **self.context,
                'detail': False,
            }).data
        return None
    
    def get_is_liked(self, obj):
        return obj.is_liked(
            request=self.context.get('request')
        )

    class Meta:
        model = Dish
        fields = [
            'id', 
            'name', 
            'original_price', 
            'discount_price', 
            'image', 
            'rating', 
            'description',
            'category',
            'total_reviews', 
            'total_likes',
            'total_orders',
            'is_disabled',
            'images',
            'is_liked',
        ]

class DetailDishSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.many_related_serializer_class = {
            'options': {
                'serializer': DishOptionSerializer,
            },
            # "user_reviews": DishReviewSerializer,
            # "liked_by_users": None,
            # "rated_by_users": None,
        }
    category = serializers.SerializerMethodField()
    images = DishImageSerializer(many=True, read_only=True)
    is_liked = serializers.SerializerMethodField()
    
    def get_category(self, obj):
        if hasattr(obj, 'category'):
            return DishCategorySerializer(obj.category, context={
                **self.context,
                'detail': False,
            }).data
        return None
    
    def get_is_liked(self, obj):
        return obj.is_liked(
            request=self.context.get('request')
        )
    
    class Meta:
        model = Dish
        fields = "__all__"

class CreateUpdateDishSerializer(serializers.ModelSerializer):
    images = serializers.ListField(
        child=serializers.ImageField(),
        write_only=True,
        required=False  
    )

    image_urls = serializers.ListField(
        child=serializers.CharField(),
        write_only=True,
        required=False  
    )

    class Meta:
        model = Dish
        fields = [
            'name', 
            'description', 
            'original_price', 
            'discount_price', 
            'image', 
            'category', 
            'restaurant', 
            'is_disabled', 
            'rating_counts', 
            'images',
            'image_urls',
        ]

    def create(self, validated_data):
        images_data = validated_data.pop('images', None)
        dish = Dish.objects.create(**validated_data)

        if images_data:
            for image_data in images_data:
                DishImage.objects.create(dish=dish, image=image_data)
        
        return dish

    def update(self, instance, validated_data):
        _id = validated_data.pop('id', None)
        _restaurant = validated_data.pop('restaurant', None)
        images_data = validated_data.pop('images', None)
        images_url_data = validated_data.pop('image_urls', None)
        print(images_data, pretty=True)
        print(images_url_data, pretty=True)
        
        if _id and _restaurant:
            print("No need to update")

        update_attr(instance, **validated_data)
        instance.save()

        # if images_data:
        #     existing_images = set(instance.images.values_list('image', flat=True))
        #     for image_data in images_data:
        #         if image_data not in existing_images:
        #             DishImage.objects.create(dish=instance, image=image_data)
        if images_data:            
            instance.images.filter(image__in=images_url_data).delete()
            for image_data in images_data:
                DishImage.objects.create(dish=instance, image=image_data)

        return instance
    
    def to_representation(self, instance):
        return DishSerializer(instance, context=self.context).data

from order.models import RestaurantCartDish
class DishInCartOrOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantCartDish
        fields = "__all__"

    def to_representation(self, instance):
        from order.models import Order, RestaurantCart
        from order.serializers.order import OrderSerializer
        from order.serializers.cart import RestaurantCartSerializer
        
        data = super().to_representation(instance)
        cart = data.get('cart', None)
        request = self.context.get('request')
        _type = request.query_params.get('type', 'order') if request and request.query_params  else "order"
        
        if cart:
            if _type == "order":
                order = Order.objects.get(cart=cart)
                order = OrderSerializer(order, context=self.context).data
                return order
            else:
                cart = RestaurantCart.objects.get(id=cart)
                cart = RestaurantCartSerializer(cart, context=self.context).data
                return cart
            
        return data
