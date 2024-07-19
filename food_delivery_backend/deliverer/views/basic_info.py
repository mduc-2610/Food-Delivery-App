# basicinfo/views.py
from rest_framework import viewsets
from deliverer.models import BasicInfo
from deliverer.serializers import BasicInfoSerializer

class BasicInfoViewSet(viewsets.ModelViewSet):
    queryset = BasicInfo.objects.all()
    serializer_class = BasicInfoSerializer
