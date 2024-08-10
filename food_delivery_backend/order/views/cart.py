# order/views.py
from rest_framework import viewsets

from order.models import Cart, RestaurantCart, RestaurantCartDish

from order.serializers import CartSerializer, RestaurantCartSerializer, RestaurantCartDishSerializer

from utils.mixins import DefaultGenericMixin

class CartViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

class RestaurantCartViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = RestaurantCart.objects.all()
    serializer_class = RestaurantCartSerializer

class RestaurantCartDishViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = RestaurantCartDish.objects.all()
    serializer_class = RestaurantCartDishSerializer
