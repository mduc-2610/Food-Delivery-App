from rest_framework import serializers
from django.contrib.contenttypes.models import ContentType
from review.models import ReviewImage

class ReviewImageSerializer(serializers.ModelSerializer):
    content_type = serializers.CharField(source='content_type.model', read_only=True)
    image = serializers.SerializerMethodField()

    class Meta:
        model = ReviewImage
        fields = [
            'id',
            'image',
            'content_type',
            'object_id',
            'created_at'
        ]

    def get_image(self, obj):
        request = self.context.get('request')
        if obj.image and hasattr(obj.image, 'url'):
            return request.build_absolute_uri(obj.image.url) if request else obj.image.url
        return None
    

class CreateReviewImageSerializer(serializers.ModelSerializer):
    content_type = serializers.SlugRelatedField(
        queryset=ContentType.objects.all(),
        slug_field='model'
    )

    class Meta:
        model = ReviewImage
        fields = [
            'id',
            'image',
            'content_type',
            'object_id',
        ]
        read_only_fields = ['id']

    def validate_content_type(self, value):
        try:
            return ContentType.objects.get(model=value)
        except ContentType.DoesNotExist:
            raise serializers.ValidationError("Invalid content type")

    def create(self, validated_data):
        content_type = validated_data.pop('content_type')
        validated_data['content_type'] = ContentType.objects.get(model=content_type)
        return super().create(validated_data)