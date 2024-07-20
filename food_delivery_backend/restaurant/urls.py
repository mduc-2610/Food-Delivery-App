# basicinfo/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    BasicInfoViewSet, 
    DetailInfoViewSet, 
    MenuDeliveryViewSet, 
    OperatingHourViewSet, 
    RepresentativeViewSet, 
    RestaurantViewSet
)

router = DefaultRouter()
router.register(r'basic-info', BasicInfoViewSet)
router.register(r'detail-info', DetailInfoViewSet)
router.register(r'menu-delivery', MenuDeliveryViewSet)
router.register(r'operating-hours', OperatingHourViewSet)
router.register(r'restaurants', RestaurantViewSet)
router.register(r'representatives', RepresentativeViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
