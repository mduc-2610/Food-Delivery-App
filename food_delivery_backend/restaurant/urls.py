# basicinfo/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    BasicInfoViewSet, 
    DetailInfoViewSet, 
    MenuDeliveryViewSet, 
    OperatingHourViewSet, 
    RepresentativeViewSet, 
    PaymentInfoViewSet,
    RestaurantViewSet, RestaurantCategoryViewSet
)

router = DefaultRouter()
router.register(r'basic-info', BasicInfoViewSet)
router.register(r'detail-info', DetailInfoViewSet)
router.register(r'payment-info', PaymentInfoViewSet)
router.register(r'menu-delivery', MenuDeliveryViewSet)
router.register(r'operating-hour', OperatingHourViewSet)
router.register(r'restaurant', RestaurantViewSet)
router.register(r'representative', RepresentativeViewSet)
router.register(r'restaurant-category', RestaurantCategoryViewSet)


urlpatterns = [
    path('', include(router.urls)),
]
