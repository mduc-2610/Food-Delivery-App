from rest_framework import viewsets

from deliverer.models import EmergencyContact

from deliverer.serializers import EmergencyContactSerializer

from utils.views import OneToOneViewSet

class EmergencyContactViewSet(OneToOneViewSet):
    queryset = EmergencyContact.objects.all()
    serializer_class = EmergencyContactSerializer
