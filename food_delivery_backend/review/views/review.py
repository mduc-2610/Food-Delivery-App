# reviews/views.py
from rest_framework import viewsets

from review.models import (
    DishReview, DelivererReview, 
    RestaurantReview, DeliveryReview
)

from account.serializers import UserAbbrSerializer
from review.serializers import (
    DishReviewSerializer, DelivererReviewSerializer, 
    RestaurantReviewSerializer, DeliveryReviewSerializer,

    CreateDelivererReviewSerializer, CreateDishReviewSerializer, 
    CreateDeliveryReviewSerializer, CreateRestaurantReviewSerializer,

    DishReviewLikeSerializer, DelivererReviewLikeSerializer, 
    RestaurantReviewLikeSerializer, DeliveryReviewLikeSerializer,
)

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet


class DishReviewViewSet(ManyRelatedViewSet):
    queryset = DishReview.objects.all()
    serializer_class = DishReviewSerializer
    pagination_class = CustomPagination
    action_serializer_class = {
        # 'liked_by_users': UserAbbrSerializer,
        'create': CreateDishReviewSerializer,
        'dish_review_likes': DishReviewLikeSerializer,
    }

class DelivererReviewViewSet(ManyRelatedViewSet):
    queryset = DelivererReview.objects.all()
    serializer_class = DelivererReviewSerializer
    pagination_class = CustomPagination
    action_serializer_class = {
        'create': CreateDelivererReviewSerializer,
    }

class RestaurantReviewViewSet(ManyRelatedViewSet):
    queryset = RestaurantReview.objects.all()
    serializer_class = RestaurantReviewSerializer
    pagination_class = CustomPagination
    action_serializer_class = {
        'create': CreateRestaurantReviewSerializer,
    }

class DeliveryReviewViewSet(ManyRelatedViewSet):
    queryset = DeliveryReview.objects.all()
    serializer_class = DeliveryReviewSerializer
    pagination_class = CustomPagination
    action_serializer_class = {
        'create': CreateDeliveryReviewSerializer,
    }

