from rest_framework import viewsets
from social.models import Comment
from social.serializers import CommentSerializer

class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
