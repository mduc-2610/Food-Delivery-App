# food/views.py
from rest_framework import viewsets
from food.models import DishLike
from food.serializers import DishLikeSerializer

class DishLikeViewSet(viewsets.ModelViewSet):
    queryset = DishLike.objects.all()
    serializer_class = DishLikeSerializer
