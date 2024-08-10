# food/views.py
from rest_framework import viewsets

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