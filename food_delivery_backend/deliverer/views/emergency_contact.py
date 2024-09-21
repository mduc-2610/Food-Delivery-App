from rest_framework import viewsets

from deliverer.models import EmergencyContact

from deliverer.serializers import (
    EmergencyContactSerializer,
    UpdateEmergencyContactSerializer,
)

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class EmergencyContactViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = EmergencyContact.objects.all()
    serializer_class = EmergencyContactSerializer
    mapping_serializer_class = {
        "update": UpdateEmergencyContactSerializer
    }