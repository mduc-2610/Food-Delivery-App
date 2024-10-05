# # promotion/views.py
# from rest_framework import viewsets

# from order.models import OrderPromotion, RestaurantPromotion, UserPromotion

# from order.serializers import OrderPromotionSerializer, RestaurantPromotionSerializer, UserPromotionSerializer

# from utils.mixins import DefaultGenericMixin

# class OrderPromotionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
#     queryset = OrderPromotion.objects.all()
#     serializer_class = OrderPromotionSerializer

# class RestaurantPromotionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
#     queryset = RestaurantPromotion.objects.all()
#     serializer_class = RestaurantPromotionSerializer

# class UserPromotionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
#     queryset = UserPromotion.objects.all()
#     serializer_class = UserPromotionSerializer
