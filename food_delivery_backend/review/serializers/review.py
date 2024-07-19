# reviews/serializers.py
from rest_framework import serializers
from review.models import DishReview, DelivererReview, RestaurantReview, OrderReview

class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ['id', 'user', 'rating', 'title', 'comment', 'created_at', 'updated_at']

class DishReviewSerializer(ReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = DishReview
        fields = ReviewSerializer.Meta.fields + ['dish']

class DelivererReviewSerializer(ReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = DelivererReview
        fields = ReviewSerializer.Meta.fields + ['deliverer']

class RestaurantReviewSerializer(ReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = RestaurantReview
        fields = ReviewSerializer.Meta.fields + ['restaurant']

class OrderReviewSerializer(ReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = OrderReview
        fields = ReviewSerializer.Meta.fields + ['order']
