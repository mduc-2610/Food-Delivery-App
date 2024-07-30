from rest_framework import serializers

from food.models import Dish

from account.serializers import UserSerializer
from food.serializers import DishSizeOptionSerializer, DishAdditionalOptionSerializer
from food.serializers.dish_like import DishLikeSerializer
from review.serializers import DishReviewSerializer
from utils.serializers import CustomRelatedModelSerializer

class DishSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dish
        fields = [
            'id', 'name', 'original_price', 
            'discount_price', 'image', 'rating', 
            'number_of_reviews'
        ]

class DetailDishSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.many_related_serializer_class = {
            'size_options': DishSizeOptionSerializer,
            'additional_options': {
                'serializer': DishAdditionalOptionSerializer,
                'context': {"detail": False}
            },
            # "user_reviews": DishReviewSerializer,
            # "liked_by_users": None,
            # "rated_by_users": None,
        }


    class Meta:
        model = Dish
        fields = "__all__"