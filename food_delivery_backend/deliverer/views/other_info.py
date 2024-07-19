# deliverer/views.py
from rest_framework import viewsets
from deliverer.models import OtherInfo
from deliverer.serializers import OtherInfoSerializer

class OtherInfoViewSet(viewsets.ModelViewSet):
    queryset = OtherInfo.objects.all()
    serializer_class = OtherInfoSerializer
