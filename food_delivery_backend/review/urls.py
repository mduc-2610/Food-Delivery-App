# reviews/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    DishReviewViewSet, DelivererReviewViewSet, RestaurantReviewViewSet, DeliveryReviewViewSet,
    DishReviewLikeViewSet, RestaurantReviewLikeViewSet, DelivererReviewLikeViewSet, DeliveryReviewLikeViewSet
)

router = DefaultRouter()
router.register(r'dish-review', DishReviewViewSet)
router.register(r'deliverer-review', DelivererReviewViewSet)
router.register(r'restaurant-review', RestaurantReviewViewSet)
router.register(r'delivery-review', DeliveryReviewViewSet)
router.register(r'dish-review-like', DishReviewLikeViewSet)
router.register(r'restaurant-review-like', RestaurantReviewLikeViewSet)
router.register(r'deliverer-review-like', DelivererReviewLikeViewSet)
router.register(r'delivery-review-like', DeliveryReviewLikeViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
