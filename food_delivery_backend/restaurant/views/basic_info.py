# basicinfo/views.py
from rest_framework import viewsets
from restaurant.models import BasicInfo
from restaurant.serializers import BasicInfoSerializer

class BasicInfoViewSet(viewsets.ModelViewSet):
    queryset = BasicInfo.objects.all()
    serializer_class = BasicInfoSerializer
