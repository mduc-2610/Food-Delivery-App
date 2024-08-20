from rest_framework import serializers
from food.models import DishOption, DishOptionItem

class DishOptionItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishOptionItem
        fields = ['id', 'name', 'price']

class DishOptionSerializer(serializers.ModelSerializer):
    items = DishOptionItemSerializer(many=True, read_only=True)

    class Meta:
        model = DishOption
        fields = ['id', 'dish', 'name', 'items']