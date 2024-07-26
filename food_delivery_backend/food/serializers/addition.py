from rest_framework import serializers
from food.models import Dish, DishAdditionalOption, DishSizeOption

class DishSizeOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishSizeOption
        fields = "__all__"

class DishAdditionalOptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishAdditionalOption
        fields = "__all__"