# deliverer/views.py
from rest_framework import viewsets
from deliverer.models import OperationInfo
from deliverer.serializers import OperationInfoSerializer

class OperationInfoViewSet(viewsets.ModelViewSet):
    queryset = OperationInfo.objects.all()
    serializer_class = OperationInfoSerializer
