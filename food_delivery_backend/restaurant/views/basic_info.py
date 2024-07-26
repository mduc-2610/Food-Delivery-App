# basicinfo/views.py
from rest_framework import viewsets

from restaurant.models import BasicInfo

from restaurant.serializers import BasicInfoSerializer

from utils.views import OneToOneViewSet

class BasicInfoViewSet(OneToOneViewSet):
    queryset = BasicInfo.objects.all()
    serializer_class = BasicInfoSerializer
