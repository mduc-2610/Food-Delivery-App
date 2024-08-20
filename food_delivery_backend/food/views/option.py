# food/views.py
from rest_framework import viewsets

from food.models import DishOption, DishOptionItem

from food.serializers import DishOptionSerializer, DishOptionItemSerializer

from utils.mixins import DefaultGenericMixin

class DishOptionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DishOption.objects.all()
    serializer_class = DishOptionSerializer

class DishOptionItemViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DishOptionItem.objects.all()
    serializer_class = DishOptionItemSerializer