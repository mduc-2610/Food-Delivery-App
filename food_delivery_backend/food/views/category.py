# food/views.py
from rest_framework import viewsets
from food.models import DishCategory
from food.serializers import DishCategorySerializer

class DishCategoryViewSet(viewsets.ModelViewSet):
    queryset = DishCategory.objects.all()
    serializer_class = DishCategorySerializer
