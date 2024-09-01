from rest_framework import viewsets

from social.models import Post

from account.serializers import BasicUserSerializer
from social.serializers import (
    PostSerializer, DetailPostSerializer, 
    CommentSerializer, PostLikeSerializer, PostImageSerializer
)

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin

class PostViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'retrieve': DetailPostSerializer,
        'liked_by_users': BasicUserSerializer,
        'user_comments': CommentSerializer,
        'post_likes': PostLikeSerializer,
        'post_images': PostImageSerializer,
    }
    
