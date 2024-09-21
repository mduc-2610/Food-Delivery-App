from rest_framework import viewsets

from deliverer.models import ResidencyInfo

from deliverer.serializers import (
    ResidencyInfoSerializer,
    UpdateResidencyInfoSerializer,
)

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class ResidencyInfoViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = ResidencyInfo.objects.all()
    serializer_class = ResidencyInfoSerializer
    mapping_serializer_class = {
        "update": UpdateResidencyInfoSerializer
    }