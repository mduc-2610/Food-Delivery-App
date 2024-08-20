# order/views.py
from rest_framework import viewsets

from order.models import RestaurantCart, RestaurantCartDish

from order.serializers import (
    RestaurantCartSerializer, RestaurantCartDishSerializer, 
    CreateRestaurantCartDishSerializer
)
from utils.mixins import DefaultGenericMixin
from utils.pagination import CustomPagination
from utils.views import OneRelatedViewSet


class RestaurantCartViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = RestaurantCart.objects.all()
    serializer_class = RestaurantCartSerializer
    pagination_class = CustomPagination

class RestaurantCartDishViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = RestaurantCartDish.objects.all()
    serializer_class = RestaurantCartDishSerializer
    pagination_class = CustomPagination

    mapping_serializer_class = {
        'create': CreateRestaurantCartDishSerializer
    }
