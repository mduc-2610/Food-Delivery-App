from rest_framework import viewsets

from deliverer.models import DriverLicense

from deliverer.serializers import DriverLicenseSerializer

from utils.views import OneRelatedViewSet

class DriverLicenseViewSet(OneRelatedViewSet):
    queryset = DriverLicense.objects.all()
    serializer_class = DriverLicenseSerializer
