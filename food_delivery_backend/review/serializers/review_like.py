# reviews/serializers.py
from rest_framework import serializers

from account.serializers import BasicUserSerializer
from review.models import (
    DishReviewLike, 
    RestaurantReviewLike, 
    DelivererReviewLike, 
    DeliveryReviewLike
)
class ReviewLikeSerializer(serializers.ModelSerializer):
    user = BasicUserSerializer()
    class Meta:
        fields = ['id', 'user', 'review', 'created_at']

class DishReviewLikeSerializer(ReviewLikeSerializer):
    class Meta(ReviewLikeSerializer.Meta):
        model = DishReviewLike

class RestaurantReviewLikeSerializer(ReviewLikeSerializer):
    class Meta(ReviewLikeSerializer.Meta):
        model = RestaurantReviewLike

class DelivererReviewLikeSerializer(ReviewLikeSerializer):
    class Meta(ReviewLikeSerializer.Meta):
        model = DelivererReviewLike

class DeliveryReviewLikeSerializer(ReviewLikeSerializer):
    class Meta(ReviewLikeSerializer.Meta):
        model = DeliveryReviewLike

class CreateReviewLikeSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ['id', 'user', 'review', 'created_at']
        read_only_fields = ['id', 'created_at']

    def to_representation(self, instance):
        data = super().to_representation(instance)
        # data['user'] = BasicUserSerializer(instance.user).data
        # from review.serializers import DishReviewSerializer
        # data['review'] = DishReviewSerializer(instance.review, context=self.context).data
        return data
    
class CreateDishReviewLikeSerializer(CreateReviewLikeSerializer):
    class Meta(CreateReviewLikeSerializer.Meta):
        model = DishReviewLike

class CreateRestaurantReviewLikeSerializer(CreateReviewLikeSerializer):
    class Meta(CreateReviewLikeSerializer.Meta):
        model = RestaurantReviewLike

class CreateDelivererReviewLikeSerializer(CreateReviewLikeSerializer):
    class Meta(CreateReviewLikeSerializer.Meta):
        model = DelivererReviewLike

class CreateDeliveryReviewLikeSerializer(CreateReviewLikeSerializer):
    class Meta(CreateReviewLikeSerializer.Meta):
        model = DeliveryReviewLike