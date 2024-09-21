from rest_framework import viewsets

from deliverer.models import OperationInfo

from deliverer.serializers import (
    OperationInfoSerializer,
    UpdateOperationInfoSerializer,
)

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class OperationInfoViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = OperationInfo.objects.all()
    serializer_class = OperationInfoSerializer
    mapping_serializer_class = {
        "update": UpdateOperationInfoSerializer
    }