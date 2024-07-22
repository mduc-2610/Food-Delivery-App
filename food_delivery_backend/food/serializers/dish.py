# food/serializers.py
from rest_framework import serializers
from food.models import Dish
from food.serializers import DishSizeOptionSerializer, DishAdditionalOptionSerializer

class DishSerializer(serializers.ModelSerializer):
    sizes = DishSizeOptionSerializer(many=True, read_only=True)
    options = DishAdditionalOptionSerializer(many=True, read_only=True)

    class Meta:
        model = Dish
        fields = ['id', 'name', 'description', 'original_price', 'discount_price', 'image', 'rating', 'number_of_reviews', 'category', 'sizes', 'options']