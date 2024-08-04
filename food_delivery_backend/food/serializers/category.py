# food/serializers.py
from rest_framework import serializers
from food.models import DishCategory

class DishCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = DishCategory
        fields = ['id', 'name', 'description', 'created_at', 'updated_at']
    