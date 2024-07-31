# food/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    DishAdditionalOptionViewSet, DishSizeOptionViewSet,
    DishCategoryViewSet, 
    DishLikeViewSet, 
    DishViewSet
)

router = DefaultRouter()
router.register(r'dish-option', DishAdditionalOptionViewSet)
router.register(r'dish-size', DishSizeOptionViewSet)
router.register(r'dish-category', DishCategoryViewSet)
router.register(r'dish-like', DishLikeViewSet)
router.register(r'dish', DishViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
