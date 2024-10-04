# food/views.py
from rest_framework import (
    viewsets, 
    response,
)

from food.models import DishCategory, Dish

from food.serializers import DishCategorySerializer, DishSerializer
from restaurant.serializers import RestaurantSerializer, RestaurantCategorySerializer

from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin

class DishCategoryViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = DishCategory.objects.all()
    serializer_class = DishCategorySerializer
    many_related_serializer_class = {
        'dishes': DishSerializer,
        'retaurants': RestaurantSerializer,
        'restaurant_categories': RestaurantCategorySerializer,
    }

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)
        return response.Response(serializer.data)