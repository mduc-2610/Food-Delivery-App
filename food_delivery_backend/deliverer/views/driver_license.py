from rest_framework import viewsets

from deliverer.models import DriverLicense

from deliverer.serializers import DriverLicenseSerializer

from utils.views import OneToOneViewSet

class DriverLicenseViewSet(OneToOneViewSet):
    queryset = DriverLicense.objects.all()
    serializer_class = DriverLicenseSerializer
