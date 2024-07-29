from rest_framework import viewsets

from deliverer.models import ResidencyInfo

from deliverer.serializers import ResidencyInfoSerializer

from utils.views import OneRelatedViewSet

class ResidencyInfoViewSet(OneRelatedViewSet):
    queryset = ResidencyInfo.objects.all()
    serializer_class = ResidencyInfoSerializer
