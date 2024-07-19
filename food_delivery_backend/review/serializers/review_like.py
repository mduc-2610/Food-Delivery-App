from rest_framework import serializers
from review.models import (
    DishReviewLike,
    RestaurantReviewLike,
    DelivererReviewLike,
    OrderReviewLike
)

class DishReviewLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishReviewLike
        fields = ['id', 'user', 'review', 'created_at']

class RestaurantReviewLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantReviewLike
        fields = ['id', 'user', 'review', 'created_at']

class DelivererReviewLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = DelivererReviewLike
        fields = ['id', 'user', 'review', 'created_at']

class OrderReviewLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderReviewLike
        fields = ['id', 'user', 'review', 'created_at']
