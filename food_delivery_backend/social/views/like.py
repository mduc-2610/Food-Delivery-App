from rest_framework import viewsets
from social.models import PostLike, CommentLike
from social.serializers import PostLikeSerializer, CommentLikeSerializer

from utils.pagination import CustomPagination

class PostLikeViewSet(viewsets.ModelViewSet):
    queryset = PostLike.objects.all()
    serializer_class = PostLikeSerializer
    pagination_class = CustomPagination

class CommentLikeViewSet(viewsets.ModelViewSet):
    queryset = CommentLike.objects.all()
    serializer_class = CommentLikeSerializer
    pagination_class = CustomPagination
