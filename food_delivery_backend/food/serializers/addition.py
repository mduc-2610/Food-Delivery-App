from rest_framework import serializers
from food.models import Dish, DishAdditionalOption, DishSizeOption

class DishSizeOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishSizeOption
        fields = ['size', 'price']

class DishAdditionalOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishAdditionalOption
        fields = ['name', 'price']