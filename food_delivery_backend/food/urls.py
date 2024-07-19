# food/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    DishAdditionalOptionViewSet, 
    DishCategoryViewSet, 
    DishLikeViewSet, 
    DishViewSet
)

router = DefaultRouter()
router.register(r'dish-option', DishAdditionalOptionViewSet)
router.register(r'dish-categorie', DishCategoryViewSet)
router.register(r'dish-like', DishLikeViewSet)
router.register(r'dish', DishViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
