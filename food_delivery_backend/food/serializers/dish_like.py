# food/serializers.py
from rest_framework import serializers

from food.models import Dish, DishLike

from account.serializers import UserAbbrSerializer

class DishLikeSerializer(serializers.ModelSerializer):
    user = UserAbbrSerializer()

    class Meta:
        model = DishLike
        fields = ['id', 'user', 'dish', 'created_at']
        read_only_fields = ['user', 'created_at']

class CreateDishLikeSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = DishLike
        fields = ['user', 'dish']