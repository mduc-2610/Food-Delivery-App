from rest_framework import serializers
from social.models import PostImage, CommentImage

class PostImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = PostImage
        fields = ['id', 'image', 'post']

class CommentImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = CommentImage
        fields = ['id', 'image', 'comment']
