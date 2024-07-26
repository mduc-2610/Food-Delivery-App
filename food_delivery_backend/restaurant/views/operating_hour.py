from rest_framework import viewsets

from restaurant.models import OperatingHour

from restaurant.serializers import OperatingHourSerializer

class OperatingHourViewSet(viewsets.ModelViewSet):
    queryset = OperatingHour.objects.all()
    serializer_class = OperatingHourSerializer
