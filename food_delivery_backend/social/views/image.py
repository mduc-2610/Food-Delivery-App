from rest_framework import viewsets

from social.models import PostImage, CommentImage

from social.serializers import PostImageSerializer, CommentImageSerializer

from utils.mixins import DefaultGenericMixin

class PostImageViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = PostImage.objects.all()
    serializer_class = PostImageSerializer

class CommentImageViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = CommentImage.objects.all()
    serializer_class = CommentImageSerializer
