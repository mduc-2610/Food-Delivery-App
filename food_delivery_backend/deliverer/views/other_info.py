from rest_framework import viewsets

from deliverer.models import OtherInfo

from deliverer.serializers import OtherInfoSerializer

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class OtherInfoViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = OtherInfo.objects.all()
    serializer_class = OtherInfoSerializer
