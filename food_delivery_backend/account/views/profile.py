from rest_framework import viewsets, status

from account.models import Profile

from account.serializers import ProfileSerializer

from utils.views import OneToOneViewSet

class ProfileViewSet(OneToOneViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
