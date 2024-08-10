# food/views.py
from rest_framework import viewsets

from food.models import DishAdditionalOption, DishSizeOption

from food.serializers import DishAdditionalOptionSerializer, DishSizeOptionSerializer

from utils.mixins import DefaultGenericMixin

class DishAdditionalOptionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DishAdditionalOption.objects.all()
    serializer_class = DishAdditionalOptionSerializer

class DishSizeOptionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DishSizeOption.objects.all()
    serializer_class = DishSizeOptionSerializer