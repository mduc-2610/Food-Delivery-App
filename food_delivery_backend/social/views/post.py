from rest_framework import viewsets

from social.models import Post

from account.serializers import UserAbbrSerializer
from social.serializers import (
    PostSerializer, DetailPostSerializer, 
    CommentSerializer, PostLikeSerializer, PostImageSerializer
)

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet

class PostViewSet(ManyRelatedViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    pagination_class = CustomPagination
    action_serializer_class = {
        'retrieve': DetailPostSerializer,
        'liked_by_users': UserAbbrSerializer,
        'user_comments': CommentSerializer,
        'post_likes': PostLikeSerializer,
        'post_images': PostImageSerializer,
    }
    
