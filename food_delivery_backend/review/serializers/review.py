# reviews/serializers.py
from rest_framework import serializers

from account.models import User
from review.models import DishReview, DelivererReview, RestaurantReview, DeliveryReview

from order.models import Order
from account.serializers import BasicUserSerializer

from utils.serializers import CustomRelatedModelSerializer

class ReviewSerializer(CustomRelatedModelSerializer):
    user = BasicUserSerializer()
    order = serializers.PrimaryKeyRelatedField(queryset=Order.objects.all())
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.one_related_serializer_class = {
            'order': 'primary_related_field'
        }
        self.many_related_serializer_class = {
            # 'liked_by_users': UserAbbrSerializer,
        }
    
    class Meta:
        fields = ['id', 'user', 'rating', 'title', 'content', 'created_at', 'updated_at', 'order']

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
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    class Meta:
        fields = ['user', 'order', 'rating', 'title', 'content']

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['user'] = BasicUserSerializer(instance.user, context=self.context).data
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