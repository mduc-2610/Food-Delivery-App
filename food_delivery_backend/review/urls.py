# reviews/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    DishReviewViewSet, DelivererReviewViewSet, RestaurantReviewViewSet, DeliveryReviewViewSet,
    DishReviewLikeViewSet, RestaurantReviewLikeViewSet, DelivererReviewLikeViewSet, DeliveryReviewLikeViewSet
)

router = DefaultRouter()
router.register(r'dish-reviews', DishReviewViewSet)
router.register(r'deliverer-reviews', DelivererReviewViewSet)
router.register(r'restaurant-reviews', RestaurantReviewViewSet)
router.register(r'order-reviews', DeliveryReviewViewSet)
router.register(r'dish-review-likes', DishReviewLikeViewSet)
router.register(r'restaurant-review-likes', RestaurantReviewLikeViewSet)
router.register(r'deliverer-review-likes', DelivererReviewLikeViewSet)
router.register(r'order-review-likes', DeliveryReviewLikeViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
