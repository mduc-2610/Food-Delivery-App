# deliverer/views.py
from rest_framework import viewsets
from deliverer.models import EmergencyContact
from deliverer.serializers import EmergencyContactSerializer

class EmergencyContactViewSet(viewsets.ModelViewSet):
    queryset = EmergencyContact.objects.all()
    serializer_class = EmergencyContactSerializer
