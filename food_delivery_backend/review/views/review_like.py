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
from account.serializers import UserAbbrSerializer
class UserResponseMixin:
    def finalize_response(self, request, response, *args, **kwargs):
        if isinstance(response, Response):
            response.data['user'] = UserAbbrSerializer(request.user).data
        return super().finalize_response(request, response, *args, **kwargs)
    
class DishReviewLikeViewSet(UserResponseMixin, viewsets.ModelViewSet):
    queryset = DishReviewLike.objects.all()
    serializer_class = DishReviewLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateDishReviewLikeSerializer,
    }

class RestaurantReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = RestaurantReviewLike.objects.all()
    serializer_class = RestaurantReviewLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateRestaurantReviewLikeSerializer,
    }

class DelivererReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = DelivererReviewLike.objects.all()
    serializer_class = DelivererReviewLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateDelivererReviewLikeSerializer,
    }

class DeliveryReviewLikeViewSet(viewsets.ModelViewSet):
    queryset = DeliveryReviewLike.objects.all()
    serializer_class = DeliveryReviewLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateDeliveryReviewLikeSerializer,
    }
