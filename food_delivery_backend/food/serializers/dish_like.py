# food/serializers.py
from rest_framework import serializers
from food.models import DishLike
from food.models import Dish  

class DishLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishLike
        fields = ['id', 'user', 'dish', 'created_at']
        read_only_fields = ['created_at']

    user = serializers.StringRelatedField()
    dish = serializers.StringRelatedField() 
