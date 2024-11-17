from rest_framework import serializers
from django.db.models import Q

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
from utils.function import reverse_absolute_uri
from utils.function import get_related_url

class DishImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishImage
        fields = "__all__"
        read_only_fields = ['id']

class DishSerializer(serializers.ModelSerializer):
    images = DishImageSerializer(many=True, read_only=True)
    image = serializers.SerializerMethodField()
    category = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()

    def get_category(self, obj):
        if hasattr(obj, 'category'):
            return DishCategorySerializer(obj.category, context={
                **self.context,
                'detail': False,
            }).data
        return None
    
    def get_image(self, obj):
        request = self.context.get('request')
        url = request.build_absolute_uri(obj.image)
        if url:
            url = '/'.join(url.split('/')[:3])
            url = f"{url}{obj.image.url}"
            # print(url)
        return url if  obj.image else None

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
            'restaurant',
            'is_liked',
        ]

class SuggestedDishSerializer(DishSerializer):
    suitability_score = serializers.SerializerMethodField()

    def get_suitability_score(self, obj):
        request = self.context.get('request')
        temperature = request.query_params.get('temperature', None) if request is not None else None
        if temperature is None: return None
        try:
            temperature = float(temperature)
        except ValueError:
            return None
        
        print(temperature, pretty=True)
        return obj.calculate_suitability_score(temperature) if temperature else None

    class Meta(DishSerializer.Meta):
        fields = DishSerializer.Meta.fields + [
            'temp_tolerance',
            'optimal_temp',
            'suitability_score'
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
        images = validated_data.pop('images', None)
        image_urls = validated_data.pop('image_urls', None)

        if _id and _restaurant:
            print("No need to update")

        instance = super().update(instance, validated_data)

        dish_images = instance.images.all()

        if image_urls:
            image_urls_reverse = [reverse_absolute_uri(url, self.context['request']) for url in image_urls]
            print('image_urls', image_urls_reverse, pretty=True)

            image_url_count = {url: image_urls_reverse.count(url) for url in image_urls_reverse}

            for dish_image in dish_images:
                image_url = dish_image.image
                # reverse_absolute_uri(dish_image.image.url, self.context['request'])                
                if image_url in image_url_count and image_url_count[image_url] > 0:
                    image_url_count[image_url] -= 1
                else:
                    print(f"Deleted image: {dish_image.image.url}")
                    dish_image.delete()
        else:
            dish_images.delete()

        if images:
            for image_data in images:
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
