# order/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from order.views import (
    CartViewSet, RestaurantCartViewSet, RestaurantCartDishViewSet, DeliveryViewSet, OrderViewSet, OrderPromotionViewSet,
    RestaurantPromotionViewSet, UserPromotionViewSet, PromotionViewSet, ActivityPromotionViewSet
)

router = DefaultRouter()
router.register(r'carts', CartViewSet)
router.register(r'restaurant-carts', RestaurantCartViewSet)
router.register(r'restaurant-cart-dishes', RestaurantCartDishViewSet)
router.register(r'deliveries', DeliveryViewSet)
router.register(r'orders', OrderViewSet)
router.register(r'order-promotions', OrderPromotionViewSet)
router.register(r'restaurant-promotions', RestaurantPromotionViewSet)
router.register(r'user-promotions', UserPromotionViewSet)
router.register(r'promotions', PromotionViewSet)
router.register(r'activity-promotions', ActivityPromotionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
