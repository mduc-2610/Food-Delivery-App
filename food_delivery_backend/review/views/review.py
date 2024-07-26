# reviews/views.py
from rest_framework import viewsets
from review.models import (
    DishReview, DelivererReview, 
    RestaurantReview, DeliveryReview
)
from review.serializers import (
    DishReviewSerializer, DelivererReviewSerializer, 
    RestaurantReviewSerializer, DeliveryReviewSerializer
)

from utils.pagination import CustomPagination

class DishReviewViewSet(viewsets.ModelViewSet):
    queryset = DishReview.objects.all()
    serializer_class = DishReviewSerializer
    pagination_class = CustomPagination

class DelivererReviewViewSet(viewsets.ModelViewSet):
    queryset = DelivererReview.objects.all()
    serializer_class = DelivererReviewSerializer

class RestaurantReviewViewSet(viewsets.ModelViewSet):
    queryset = RestaurantReview.objects.all()
    serializer_class = RestaurantReviewSerializer

class DeliveryReviewViewSet(viewsets.ModelViewSet):
    queryset = DeliveryReview.objects.all()
    serializer_class = DeliveryReviewSerializer
