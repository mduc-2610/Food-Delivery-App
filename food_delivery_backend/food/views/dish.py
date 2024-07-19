# food/views.py
from rest_framework import viewsets
from food.models import Dish
from food.serializers import DishSerializer

class DishViewSet(viewsets.ModelViewSet):
    queryset = Dish.objects.all()
    serializer_class = DishSerializer
