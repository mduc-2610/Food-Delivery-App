# reviews/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    DishReviewViewSet, RestaurantReviewViewSet, DelivererReviewViewSet, DeliveryReviewViewSet,
    DishReviewLikeViewSet, RestaurantReviewLikeViewSet, DelivererReviewLikeViewSet, DeliveryReviewLikeViewSet,
    DishReviewReplyViewSet, RestaurantReviewReplyViewSet, DelivererReviewReplyViewSet, DeliveryReviewReplyViewSet,
    ReviewImageViewSet
)

router = DefaultRouter()
router.register(r'dish-review', DishReviewViewSet)
router.register(r'deliverer-review', DelivererReviewViewSet)
router.register(r'restaurant-review', RestaurantReviewViewSet)
router.register(r'delivery-review', DeliveryReviewViewSet)

router.register(r'dish-review-reply', DishReviewReplyViewSet)
router.register(r'deliverer-review-reply', DelivererReviewReplyViewSet)
router.register(r'restaurant-review-reply', RestaurantReviewReplyViewSet)
router.register(r'delivery-review-reply', DeliveryReviewReplyViewSet)

router.register(r'dish-review-like', DishReviewLikeViewSet)
router.register(r'restaurant-review-like', RestaurantReviewLikeViewSet)
router.register(r'deliverer-review-like', DelivererReviewLikeViewSet)
router.register(r'delivery-review-like', DeliveryReviewLikeViewSet)

router.register(r'review-image', ReviewImageViewSet, basename='review-image')

urlpatterns = [
    path('', include(router.urls)),
]
