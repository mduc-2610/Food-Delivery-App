# comments/serializers.py
from rest_framework import serializers
from social.models import Comment

class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ['id', 'post', 'user', 'text', 'created_at', 'updated_at', 'is_active']
