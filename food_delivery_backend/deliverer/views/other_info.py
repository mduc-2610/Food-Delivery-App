from rest_framework import viewsets

from deliverer.models import OtherInfo

from deliverer.serializers import OtherInfoSerializer

from utils.views import OneRelatedViewSet

class OtherInfoViewSet(OneRelatedViewSet):
    queryset = OtherInfo.objects.all()
    serializer_class = OtherInfoSerializer
