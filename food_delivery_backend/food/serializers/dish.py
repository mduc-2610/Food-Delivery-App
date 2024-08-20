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
            'id', 'name', 'original_price', 
            'discount_price', 'image', 'rating', 'description',
            'total_reviews', 'total_likes'
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