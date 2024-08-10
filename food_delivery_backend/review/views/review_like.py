from rest_framework import viewsets, response
from rest_framework.response import Response
from review.models import (
    DishReviewLike,
    RestaurantReviewLike,
    DelivererReviewLike,
    DeliveryReviewLike
)
from review.serializers import (
    DishReviewLikeSerializer, CreateDishReviewLikeSerializer,
    RestaurantReviewLikeSerializer, CreateRestaurantReviewLikeSerializer,
    DelivererReviewLikeSerializer, CreateDelivererReviewLikeSerializer,
    DeliveryReviewLikeSerializer, CreateDeliveryReviewLikeSerializer,
)

from utils.pagination import CustomPagination
from utils.mixins import DefaultGenericMixin

class DishReviewLikeViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DishReviewLike.objects.all()
    serializer_class = DishReviewLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateDishReviewLikeSerializer,
    }

class RestaurantReviewLikeViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = RestaurantReviewLike.objects.all()
    serializer_class = RestaurantReviewLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateRestaurantReviewLikeSerializer,
    }

class DelivererReviewLikeViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DelivererReviewLike.objects.all()
    serializer_class = DelivererReviewLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateDelivererReviewLikeSerializer,
    }

class DeliveryReviewLikeViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DeliveryReviewLike.objects.all()
    serializer_class = DeliveryReviewLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateDeliveryReviewLikeSerializer,
    }
