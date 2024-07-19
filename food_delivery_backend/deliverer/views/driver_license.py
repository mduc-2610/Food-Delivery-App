# deliverer/views.py
from rest_framework import viewsets
from deliverer.models import DriverLicense
from deliverer.serializers import DriverLicenseSerializer

class DriverLicenseViewSet(viewsets.ModelViewSet):
    queryset = DriverLicense.objects.all()
    serializer_class = DriverLicenseSerializer
