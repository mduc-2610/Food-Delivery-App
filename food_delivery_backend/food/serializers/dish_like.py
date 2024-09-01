# food/serializers.py
from rest_framework import serializers

from food.models import Dish, DishLike

from account.serializers import BasicUserSerializer

class DishLikeSerializer(serializers.ModelSerializer):
    user = BasicUserSerializer()

    class Meta:
        model = DishLike
        fields = ['id', 'user', 'dish', 'created_at']
        read_only_fields = ['user', 'created_at']

class CreateDishLikeSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = DishLike
        fields = ['user', 'dish']