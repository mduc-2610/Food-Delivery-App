from rest_framework import viewsets
from review.models import (
    DishReviewLike,
    RestaurantReviewLike,
    DelivererReviewLike,
    DeliveryReviewLike
)
from review.serializers import (
    DishReviewLikeSerializer,
    RestaurantReviewLikeSerializer,
    DelivererReviewLikeSerializer,
    DeliveryReviewLikeSerializer
)

from utils.pagination import CustomPagination

class DishReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = DishReviewLike.objects.all()
    serializer_class = DishReviewLikeSerializer
    pagination_class = CustomPagination

class RestaurantReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = RestaurantReviewLike.objects.all()
    serializer_class = RestaurantReviewLikeSerializer
    pagination_class = CustomPagination

class DelivererReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = DelivererReviewLike.objects.all()
    serializer_class = DelivererReviewLikeSerializer
    pagination_class = CustomPagination

class DeliveryReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = DeliveryReviewLike.objects.all()
    serializer_class = DeliveryReviewLikeSerializer
    pagination_class = CustomPagination
