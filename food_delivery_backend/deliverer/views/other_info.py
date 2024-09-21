from rest_framework import viewsets

from deliverer.models import OtherInfo

from deliverer.serializers import (
    OtherInfoSerializer,
    UpdateOtherInfoSerializer,
)

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class OtherInfoViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = OtherInfo.objects.all()
    serializer_class = OtherInfoSerializer
    mapping_serializer_class = {
        "update": UpdateOtherInfoSerializer
    }