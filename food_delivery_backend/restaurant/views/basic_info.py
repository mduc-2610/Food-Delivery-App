# basicinfo/views.py
from rest_framework import viewsets

from restaurant.models import BasicInfo

from restaurant.serializers import (
    BasicInfoSerializer,
    UpdateBasicInfoSerializer,
)

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class BasicInfoViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = BasicInfo.objects.all()
    serializer_class = BasicInfoSerializer
    mapping_serializer_class = {
        'update': UpdateBasicInfoSerializer,
    }
