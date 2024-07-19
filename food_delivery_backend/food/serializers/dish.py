# food/serializers.py
from rest_framework import serializers
from food.models import Dish

class DishSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dish
        fields = ['id', 'name', 'description', 'original_price', 'discount_price', 'image', 'rating', 'number_of_reviews', 'category']
