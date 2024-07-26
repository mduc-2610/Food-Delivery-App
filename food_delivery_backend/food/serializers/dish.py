from rest_framework import serializers
from food.models import Dish
from food.serializers import DishSizeOptionSerializer, DishAdditionalOptionSerializer
from account.serializers import UserSerializer

class DishSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dish
        fields = [
            'id', 'name', 'original_price', 
            'discount_price', 'image', 'rating', 
            'number_of_reviews'
        ]

from utils.serializers import CustomRelatedModelSerializer

class DetailDishSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.one_related_serializer_class = {
            
        }
        self.many_related_serializer_class = {
            'size_options': DishSizeOptionSerializer,
            'additional_options': DishAdditionalOptionSerializer
        }
    class Meta:
        model = Dish
        fields = "__all__"