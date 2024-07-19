# promotion/views.py
from rest_framework import viewsets
from order.models import OrderPromotion, RestaurantPromotion, UserPromotion
from order.serializers import OrderPromotionSerializer, RestaurantPromotionSerializer, UserPromotionSerializer

class OrderPromotionViewSet(viewsets.ModelViewSet):
    queryset = OrderPromotion.objects.all()
    serializer_class = OrderPromotionSerializer

class RestaurantPromotionViewSet(viewsets.ModelViewSet):
    queryset = RestaurantPromotion.objects.all()
    serializer_class = RestaurantPromotionSerializer

class UserPromotionViewSet(viewsets.ModelViewSet):
    queryset = UserPromotion.objects.all()
    serializer_class = UserPromotionSerializer
