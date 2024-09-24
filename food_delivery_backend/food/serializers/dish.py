from rest_framework import serializers

from food.models import Dish

from account.serializers import UserSerializer
from food.serializers.option import DishOptionSerializer
from food.serializers.dish_like import DishLikeSerializer
from review.serializers import DishReviewSerializer
from utils.serializers import CustomRelatedModelSerializer

class DishSerializer(serializers.ModelSerializer):
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
            'total_reviews', 
            'total_likes',
            'total_orders',
            'is_disabled',
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


    class Meta:
        model = Dish
        fields = "__all__"

from order.models import RestaurantCartDish
class DishInCartOrOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantCartDish
        fields = "__all__"

    def to_representation(self, instance):
        data = super().to_representation(instance)
        cart = data.get('cart', None)
        from order.models import Order, RestaurantCart
        from order.serializers.order import OrderSerializer
        from order.serializers.cart import RestaurantCartSerializer
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