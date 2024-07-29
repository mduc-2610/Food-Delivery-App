from rest_framework import viewsets

from deliverer.models import EmergencyContact

from deliverer.serializers import EmergencyContactSerializer

from utils.views import OneRelatedViewSet

class EmergencyContactViewSet(OneRelatedViewSet):
    queryset = EmergencyContact.objects.all()
    serializer_class = EmergencyContactSerializer
