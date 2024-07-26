from rest_framework import serializers
from review.models import (
    DishReviewLike,
    RestaurantReviewLike,
    DelivererReviewLike,
    DeliveryReviewLike
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

class DeliveryReviewLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryReviewLike
        fields = ['id', 'user', 'review', 'created_at']
