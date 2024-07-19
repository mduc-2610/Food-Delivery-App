from rest_framework import viewsets
from social.models import PostImage, CommentImage
from social.serializers import PostImageSerializer, CommentImageSerializer

class PostImageViewSet(viewsets.ModelViewSet):
    queryset = PostImage.objects.all()
    serializer_class = PostImageSerializer

class CommentImageViewSet(viewsets.ModelViewSet):
    queryset = CommentImage.objects.all()
    serializer_class = CommentImageSerializer
