# food/serializers.py
from rest_framework import serializers
from food.models import DishCategory


from utils.serializers import CustomRelatedModelSerializer

class DishCategorySerializer(CustomRelatedModelSerializer):
    class Meta:
        model = DishCategory
        fields = ['id', 'name', 'description', 'created_at', 'updated_at', 'image']
    