# food/views.py
from rest_framework import viewsets
from food.models import DishAdditionalOption, DishSizeOption
from food.serializers import DishAdditionalOptionSerializer, DishSizeOptionSerializer

class DishAdditionalOptionViewSet(viewsets.ModelViewSet):
    queryset = DishAdditionalOption.objects.all()
    serializer_class = DishAdditionalOptionSerializer

class DishSizeOptionViewSet(viewsets.ModelViewSet):
    queryset = DishSizeOption.objects.all()
    serializer_class = DishSizeOptionSerializer