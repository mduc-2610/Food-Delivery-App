from rest_framework import viewsets

from deliverer.models import BasicInfo

from deliverer.serializers import BasicInfoSerializer

from utils.views import OneToOneViewSet

class BasicInfoViewSet(OneToOneViewSet):
    queryset = BasicInfo.objects.all()
    serializer_class = BasicInfoSerializer
