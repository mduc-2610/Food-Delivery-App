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

    image_urls_delete = serializers.ListField(
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
            'image_urls_delete', 
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
        image_urls_delete = validated_data.pop('image_urls_delete', None)
        
        instance = super().update(instance, validated_data)

        if images:
            for image_data in images:
                ReviewImage.objects.create(
                    object_id=instance.id,
                    content_type=ContentType.objects.get_for_model(instance),
                    image=image_data
                )

        if image_urls_delete:
            for _image_url in image_urls_delete:
                _image = ReviewImage.objects.filter(
                    object_id=instance.id,
                    content_type=ContentType.objects.get_for_model(instance),
                    image=_image_url
                ).first()
                
                print('Found', _image)
                if _image: 
                    x = _image.delete()

        return instance
    
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
