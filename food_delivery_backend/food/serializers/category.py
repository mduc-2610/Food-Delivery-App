# food/serializers.py
from rest_framework import serializers
from food.models import DishCategory

class DishCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = DishCategory
        fields = ['id', 'name', 'description', 'created_at', 'updated_at', 'dish_count']
    
    dish_count = serializers.SerializerMethodField()

    def get_dish_count(self, obj):
        return obj.dish_count()
