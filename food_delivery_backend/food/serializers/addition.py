# food/serializers.py
from rest_framework import serializers
from food.models import DishAdditionalOption

class DishAdditionalOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishAdditionalOption
        fields = ['id', 'dish', 'name', 'price']
