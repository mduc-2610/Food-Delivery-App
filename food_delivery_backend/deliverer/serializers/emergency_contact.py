# deliverer/serializers.py
from rest_framework import serializers
from deliverer.models import EmergencyContact

class EmergencyContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmergencyContact
        fields = ['id', 'name', 'relationship', 'phone_number']
