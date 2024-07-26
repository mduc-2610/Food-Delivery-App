from rest_framework import viewsets

from deliverer.models import ResidencyInfo

from deliverer.serializers import ResidencyInfoSerializer

from utils.views import OneToOneViewSet

class ResidencyInfoViewSet(OneToOneViewSet):
    queryset = ResidencyInfo.objects.all()
    serializer_class = ResidencyInfoSerializer
