from rest_framework import viewsets
from social.models import Like
from social.serializers import LikeSerializer

class LikeViewSet(viewsets.ModelViewSet):
    queryset = Like.objects.all()
    serializer_class = LikeSerializer
