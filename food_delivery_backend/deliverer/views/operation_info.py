from rest_framework import viewsets

from deliverer.models import OperationInfo

from deliverer.serializers import OperationInfoSerializer

from utils.views import OneToOneViewSet

class OperationInfoViewSet(OneToOneViewSet):
    queryset = OperationInfo.objects.all()
    serializer_class = OperationInfoSerializer
