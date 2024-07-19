# profiles/views.py
from rest_framework import viewsets

from account.models import Profile
from account.serializers import ProfileSerializer

class ProfileViewSet(viewsets.ModelViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
