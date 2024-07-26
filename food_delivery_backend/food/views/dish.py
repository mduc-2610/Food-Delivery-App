from rest_framework import (
    response, viewsets, status
)
from rest_framework.decorators import action

from food.models import Dish

from food.serializers import DishSerializer, DetailDishSerializer

class DishViewSet(viewsets.ModelViewSet):
    queryset = Dish.objects.all()
    serializer_class = DishSerializer

    def get_serializer_class(self):
        if self.action == "retrieve":
            return DetailDishSerializer
        return super().get_serializer_class()