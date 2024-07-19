# order/views.py
from rest_framework import viewsets
from order.models import Cart, RestaurantCart, RestaurantCartDish
from order.serializers import CartSerializer, RestaurantCartSerializer, RestaurantCartDishSerializer

class CartViewSet(viewsets.ModelViewSet):
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

class RestaurantCartViewSet(viewsets.ModelViewSet):
    queryset = RestaurantCart.objects.all()
    serializer_class = RestaurantCartSerializer

class RestaurantCartDishViewSet(viewsets.ModelViewSet):
    queryset = RestaurantCartDish.objects.all()
    serializer_class = RestaurantCartDishSerializer
