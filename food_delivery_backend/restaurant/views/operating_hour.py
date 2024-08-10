from rest_framework import viewsets

from restaurant.models import OperatingHour

from restaurant.serializers import OperatingHourSerializer
from utils.mixins import DefaultGenericMixin

class OperatingHourViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = OperatingHour.objects.all()
    serializer_class = OperatingHourSerializer
