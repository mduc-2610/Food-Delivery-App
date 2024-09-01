# order/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from order.views import (
    RestaurantCartViewSet, RestaurantCartDishViewSet, DeliveryViewSet, 
    DeliveryRequestViewSet,
    OrderViewSet, OrderPromotionViewSet,
    RestaurantPromotionViewSet, UserPromotionViewSet, PromotionViewSet, ActivityPromotionViewSet
)

router = DefaultRouter()
router.register(r'restaurant-cart', RestaurantCartViewSet)
router.register(r'restaurant-cart-dish', RestaurantCartDishViewSet)
router.register(r'delivery', DeliveryViewSet)
router.register(r'delivery-request', DeliveryRequestViewSet)
router.register(r'order', OrderViewSet)
router.register(r'order-promotion', OrderPromotionViewSet)
router.register(r'restaurant-promotion', RestaurantPromotionViewSet)
router.register(r'user-promotion', UserPromotionViewSet)
router.register(r'promotion', PromotionViewSet)
router.register(r'activity-promotion', ActivityPromotionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
