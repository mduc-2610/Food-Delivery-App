# reviews/serializers.py
from rest_framework import serializers
from django.contrib.contenttypes.models import ContentType

from account.models import User
from review.models import (
    DishReview,
    DelivererReview,
    RestaurantReview,
    DeliveryReview,
)

from review.serializers.review_reply import (
    DishReviewReplySerializer,
    DelivererReviewReplySerializer,
    RestaurantReviewReplySerializer,
    DeliveryReviewReplySerializer,
)
from review.models import (
    ReviewImage
)

from review.serializers.review_image import ReviewImageSerializer
from order.models import Order
from account.serializers import BasicUserSerializer

from utils.serializers import CustomRelatedModelSerializer
from utils.function import reverse_absolute_uri

class ReviewSerializer(CustomRelatedModelSerializer):
    user = BasicUserSerializer()
    order = serializers.PrimaryKeyRelatedField(queryset=Order.objects.all())
    is_liked = serializers.SerializerMethodField()
    images = serializers.SerializerMethodField()

    def get_images(self, obj):
        _model = self.Meta.model
        queryset = ReviewImage.objects.filter(
            content_type=ContentType.objects.get_for_model(_model),
            object_id=obj.id,
        )
        return ReviewImageSerializer(queryset, many=True, context=self.context).data

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.one_related_serializer_class = {
            'order': 'primary_related_field'
        }
        self.many_related_serializer_class = {
            # 'liked_by_users': UserAbbrSerializer,
        }

    def get_is_liked(self, obj):
        return obj.is_liked(
            request=self.context.get('request'),
        )
    
    class Meta:
        fields = [
            'id', 
            'user', 
            'rating', 
            'title', 
            'content', 
            'created_at', 
            'updated_at', 
            'order', 
            'total_likes', 
            'total_replies',
            'is_liked',
            'images',
        ]

class DishReviewSerializer(ReviewSerializer):
    replies = serializers.SerializerMethodField()
    def get_replies(self, obj):
        return DishReviewReplySerializer(obj.dish_replies, many=True, context=self.context).data
    
    class Meta(ReviewSerializer.Meta):
        model = DishReview
        fields = ReviewSerializer.Meta.fields + [
            'dish', 
            'replies'
        ]

class DelivererReviewSerializer(ReviewSerializer):
    replies = serializers.SerializerMethodField()
    def get_replies(self, obj):
        return DelivererReviewReplySerializer(obj.deliverer_replies, many=True, context=self.context).data

    class Meta(ReviewSerializer.Meta):
        model = DelivererReview
        fields = ReviewSerializer.Meta.fields + [
            'deliverer', 
            'replies'
        ]

class RestaurantReviewSerializer(ReviewSerializer):
    replies = serializers.SerializerMethodField()
    def get_replies(self, obj):
        return RestaurantReviewReplySerializer(obj.restaurant_replies, many=True, context=self.context).data

    class Meta(ReviewSerializer.Meta):
        model = RestaurantReview
        fields = ReviewSerializer.Meta.fields + [
            'restaurant', 
            'replies'
        ]

class DeliveryReviewSerializer(ReviewSerializer):
    replies = serializers.SerializerMethodField()
    def get_replies(self, obj):
        return DeliveryReviewReplySerializer(obj.delivery_replies, many=True, context=self.context).data

    class Meta(ReviewSerializer.Meta):
        model = DeliveryReview
        fields = ReviewSerializer.Meta.fields + [
            'delivery', 
            'replies'
        ]

    
class CreateUpdateReviewSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    images = serializers.ListField(
        child=serializers.ImageField(),
        write_only=True,
        required=False   
    )

    image_urls = serializers.ListField(
        child=serializers.CharField(),
        write_only=True,
        required=False   
    )

    class Meta:
        fields = [
            'user',
            'order',
            'rating',
            'title',
            'content',
            'images',
            'image_urls',
        ]

    def create(self, validated_data):
        images_data = validated_data.pop('images', None)
        instance = super().create(validated_data)

        if images_data:
            for image_data in images_data:
                ReviewImage.objects.create(
                    object_id=instance.id,
                    content_type=ContentType.objects.get_for_model(instance),
                    image=image_data
                )

        return instance

    def update(self, instance, validated_data):
        validated_data.pop('user', None)
        validated_data.pop('order', None)
        images = validated_data.pop('images', None)
        image_urls = validated_data.pop('image_urls', None)
        
        instance = super().update(instance, validated_data)
        
        review_images = ReviewImage.objects.filter(
            object_id=instance.id,
            content_type=ContentType.objects.get_for_model(instance),
        )
        print('new_images', images, pretty=True)
        if image_urls:
            image_urls_reverse = [reverse_absolute_uri(url, self.context['request']) for url in image_urls]
            print('image_urls', image_urls_reverse, pretty=True)

            image_url_count = {url: image_urls_reverse.count(url) for url in image_urls_reverse}

            for review_image in review_images:
                image_url = review_image.image
                # reverse_absolute_uri(review_image.image.url, self.context['request'])                
                if image_url in image_url_count and image_url_count[image_url] > 0:
                    image_url_count[image_url] -= 1
                else:
                    print(f"Deleted image: {review_image.image.url}")
                    review_image.delete()
        else:
            review_images.delete()

        if images:
            for image_data in images:
                x = ReviewImage.objects.create(
                    object_id=instance.id,
                    content_type=ContentType.objects.get_for_model(instance),
                    image=image_data
                )
                print("created", x, pretty=True)

        return instance
    
    def to_internal_value(self, data):
        print("Incoming data:", "____________________________-")
        for k, v in data.items():
            print(k, v)
        print("_____________________________________")
        try:
            return super().to_internal_value(data)
        except serializers.ValidationError as e:
            print("Validation errors:", e.detail)
            raise

class CreateUpdateDishReviewSerializer(CreateUpdateReviewSerializer):
    class Meta(CreateUpdateReviewSerializer.Meta):
        model = DishReview
        fields = CreateUpdateReviewSerializer.Meta.fields + ['dish']
    
    def to_representation(self, instance):
        data = super().to_representation(instance)
        # print('CREATED DATA', data, pretty=True)
        return DishReviewSerializer(instance, context=self.context).data
    
class CreateUpdateDelivererReviewSerializer(CreateUpdateReviewSerializer):
    class Meta(CreateUpdateReviewSerializer.Meta):
        model = DelivererReview
        fields = CreateUpdateReviewSerializer.Meta.fields + ['deliverer']

    def to_representation(self, instance):
        # data = super().to_representation(instance)
        return DelivererReviewSerializer(instance, context=self.context).data
    
class CreateUpdateRestaurantReviewSerializer(CreateUpdateReviewSerializer):
    class Meta(CreateUpdateReviewSerializer.Meta):
        model = RestaurantReview
        fields = CreateUpdateReviewSerializer.Meta.fields + ['restaurant']

    def to_representation(self, instance):
        # data = super().to_representation(instance)
        return RestaurantReviewSerializer(instance, context=self.context).data
    
class CreateUpdateDeliveryReviewSerializer(CreateUpdateReviewSerializer):
    class Meta(CreateUpdateReviewSerializer.Meta):
        model = DeliveryReview
        fields = CreateUpdateReviewSerializer.Meta.fields + ['delivery']
    
    def to_representation(self, instance):
        # data = super().to_representation(instance)
        return DeliveryReviewSerializer(instance, context=self.context).data