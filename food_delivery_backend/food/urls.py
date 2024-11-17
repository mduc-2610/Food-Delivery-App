# food/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    DishOptionViewSet,
    DishOptionItemViewSet,
    DishCategoryViewSet, 
    DishLikeViewSet, 
    DishViewSet,
    DishImageViewSet,
    WeatherView
)

router = DefaultRouter()
router.register(r'dish-option', DishOptionViewSet)
router.register(r'dish-option-item', DishOptionItemViewSet)
router.register(r'dish-category', DishCategoryViewSet)
router.register(r'dish-like', DishLikeViewSet)
router.register(r'dish', DishViewSet)
router.register(r'dish-image', DishImageViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('weather/', WeatherView.as_view(), name='weather'),
]
