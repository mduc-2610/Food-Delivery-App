# reviews/serializers.py
from rest_framework import serializers

from review.models import DishReview, DelivererReview, RestaurantReview, DeliveryReview

from account.serializers import UserAbbrSerializer

from utils.serializers import CustomRelatedModelSerializer

class ReviewSerializer(CustomRelatedModelSerializer):
    user = UserAbbrSerializer()

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.many_related_serializer_class = {
            # 'liked_by_users': UserAbbrSerializer,
        }
    
    class Meta:
        fields = ['id', 'user', 'rating', 'title', 'content', 'created_at', 'updated_at']

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

class DeliveryReviewSerializer(ReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = DeliveryReview
        fields = ReviewSerializer.Meta.fields + ['delivery']

    

class CreateReviewSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ['user', 'rating', 'title', 'content']

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['user'] = UserAbbrSerializer(instance.user, context=self.context).data
        return data

class CreateDishReviewSerializer(CreateReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = DishReview
        fields = ReviewSerializer.Meta.fields + ['dish']

class CreateDelivererReviewSerializer(CreateReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = DelivererReview
        fields = ReviewSerializer.Meta.fields + ['deliverer']

class CreateRestaurantReviewSerializer(CreateReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = RestaurantReview
        fields = ReviewSerializer.Meta.fields + ['restaurant']

class CreateDeliveryReviewSerializer(CreateReviewSerializer):
    class Meta(ReviewSerializer.Meta):
        model = DeliveryReview
        fields = ReviewSerializer.Meta.fields + ['delivery']