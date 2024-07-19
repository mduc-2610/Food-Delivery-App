from rest_framework import serializers
from social.models import Post

class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ['id', 'user', 'title', 'content', 'created_at']
