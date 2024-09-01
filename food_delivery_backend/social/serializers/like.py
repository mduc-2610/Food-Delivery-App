from rest_framework import serializers

from social.models import PostLike, CommentLike

from account.serializers import BasicUserSerializer

class PostLikeSerializer(serializers.ModelSerializer):
    user = BasicUserSerializer()
    class Meta:
        model = PostLike
        fields = ['id', 'user', 'post', 'created_at']

class CommentLikeSerializer(serializers.ModelSerializer):
    user = BasicUserSerializer()
    class Meta:
        model = CommentLike
        fields = ['id', 'user', 'comment', 'created_at']
