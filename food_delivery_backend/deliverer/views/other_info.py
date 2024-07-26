from rest_framework import viewsets

from deliverer.models import OtherInfo

from deliverer.serializers import OtherInfoSerializer

from utils.views import OneToOneViewSet

class OtherInfoViewSet(OneToOneViewSet):
    queryset = OtherInfo.objects.all()
    serializer_class = OtherInfoSerializer
