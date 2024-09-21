from rest_framework import viewsets

from deliverer.models import DriverLicense

from deliverer.serializers import (
    DriverLicenseSerializer,
    UpdateDriverLicenseSerializer,
)

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class DriverLicenseViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = DriverLicense.objects.all()
    serializer_class = DriverLicenseSerializer
    mapping_serializer_class = {
        "update": UpdateDriverLicenseSerializer
    }
