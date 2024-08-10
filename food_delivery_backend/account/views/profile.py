from rest_framework import viewsets, status

from account.models import Profile

from account.serializers import ProfileSerializer

from utils.views import OneRelatedViewSet

from utils.mixins import DefaultGenericMixin

class ProfileViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer