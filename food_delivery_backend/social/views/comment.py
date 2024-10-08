from rest_framework import viewsets

from account.serializers import BasicUserSerializer
from social.models import Comment
from social.serializers import (
    CommentSerializer, CommentLikeSerializer, CommentImageSerializer
)
from utils.pagination import CustomPagination

from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin


class CommentViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'liked_by_users': BasicUserSerializer,
        'comment_likes': CommentLikeSerializer,
        'comment_images': CommentImageSerializer,
    }
