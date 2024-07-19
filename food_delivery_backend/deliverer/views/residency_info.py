# deliverer/views.py
from rest_framework import viewsets
from deliverer.models import ResidencyInfo
from deliverer.serializers import ResidencyInfoSerializer

class ResidencyInfoViewSet(viewsets.ModelViewSet):
    queryset = ResidencyInfo.objects.all()
    serializer_class = ResidencyInfoSerializer
