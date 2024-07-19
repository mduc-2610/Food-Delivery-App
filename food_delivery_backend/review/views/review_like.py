from rest_framework import viewsets
from review.models import (
    DishReviewLike,
    RestaurantReviewLike,
    DelivererReviewLike,
    OrderReviewLike
)
from review.serializers import (
    DishReviewLikeSerializer,
    RestaurantReviewLikeSerializer,
    DelivererReviewLikeSerializer,
    OrderReviewLikeSerializer
)

class DishReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = DishReviewLike.objects.all()
    serializer_class = DishReviewLikeSerializer

class RestaurantReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = RestaurantReviewLike.objects.all()
    serializer_class = RestaurantReviewLikeSerializer

class DelivererReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = DelivererReviewLike.objects.all()
    serializer_class = DelivererReviewLikeSerializer

class OrderReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = OrderReviewLike.objects.all()
    serializer_class = OrderReviewLikeSerializer
