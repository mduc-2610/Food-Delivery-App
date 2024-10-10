# review/serializers.py

from rest_framework import serializers
from django.contrib.contenttypes.models import ContentType

from account.models import User
from review.models import ReviewImage
from review.serializers.review_image import ReviewImageSerializer
from review.models import (
    DishReviewReply,
    RestaurantReviewReply,
    DelivererReviewReply,
    DeliveryReviewReply,
)


from account.serializers import BasicUserSerializer
from utils.function import reverse_absolute_uri

class ReviewReplySerializer(serializers.ModelSerializer):
    user = BasicUserSerializer(read_only=True)
    images = serializers.SerializerMethodField()

    def get_images(self, obj):
        _model = self.Meta.model
        queryset = ReviewImage.objects.filter(
            content_type=ContentType.objects.get_for_model(_model),
            object_id=obj.id,
        )
        return ReviewImageSerializer(queryset, many=True, context=self.context).data

    class Meta:
        # model = ReviewReply
        fields = [
            'id', 
            'user', 
            'title',
            'content', 
            'created_at', 
            'updated_at',
            'review',
            'images',
        ]

class DishReviewReplySerializer(ReviewReplySerializer):
    class Meta(ReviewReplySerializer.Meta):
        model = DishReviewReply
        # fields = ReviewReplySerializer.Meta.fields + ['review']

class RestaurantReviewReplySerializer(ReviewReplySerializer):
    class Meta(ReviewReplySerializer.Meta):
        model = RestaurantReviewReply
        # fields = ReviewReplySerializer.Meta.fields + ['review']

class DelivererReviewReplySerializer(ReviewReplySerializer):
    class Meta(ReviewReplySerializer.Meta):
        model = DelivererReviewReply
        # fields = ReviewReplySerializer.Meta.fields + ['review']

class DeliveryReviewReplySerializer(ReviewReplySerializer):
    class Meta(ReviewReplySerializer.Meta):
        model = DeliveryReviewReply
        # fields = ReviewReplySerializer.Meta.fields + ['review']


class CreateUpdateReviewReplySerializer(serializers.ModelSerializer):
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
        # model = ReviewReply
        fields = [
            'user',
            'title',
            'content',
            'review',
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
        validated_data.pop('user')
        images = validated_data.pop('images', None)
        image_urls = validated_data.pop('image_urls', None)
        
        instance = super().update(instance, validated_data)

        review_images = ReviewImage.objects.filter(
            object_id=instance.id,
            content_type=ContentType.objects.get_for_model(instance),
        )
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
                ReviewImage.objects.create(
                    object_id=instance.id,
                    content_type=ContentType.objects.get_for_model(instance),
                    image=image_data
                )
                
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

class CreateUpdateDishReviewReplySerializer(CreateUpdateReviewReplySerializer):

    class Meta(CreateUpdateReviewReplySerializer.Meta):
        model = DishReviewReply

    def to_representation(self, instance):
        return DishReviewReplySerializer(instance, context=self.context).data

class CreateUpdateRestaurantReviewReplySerializer(CreateUpdateReviewReplySerializer):

    class Meta(CreateUpdateReviewReplySerializer.Meta):
        model = RestaurantReviewReply

    def to_representation(self, instance):
        return RestaurantReviewReplySerializer(instance, context=self.context).data

class CreateUpdateDelivererReviewReplySerializer(CreateUpdateReviewReplySerializer):

    class Meta(CreateUpdateReviewReplySerializer.Meta):
        model = DelivererReviewReply

    def to_representation(self, instance):
        return DelivererReviewReplySerializer(instance, context=self.context).data

class CreateUpdateDeliveryReviewReplySerializer(CreateUpdateReviewReplySerializer):

    class Meta(CreateUpdateReviewReplySerializer.Meta):
        model = DeliveryReviewReply

    def to_representation(self, instance):
        return DeliveryReviewReplySerializer(instance, context=self.context).data
