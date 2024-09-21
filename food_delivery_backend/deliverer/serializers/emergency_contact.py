from rest_framework import serializers
from deliverer.models import EmergencyContact

class BaseEmergencyContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmergencyContact
        fields = [
            'id',
            'deliverer',
            'name',
            'relationship',
            'phone_number',
        ]
        read_only_fields = ['id']

class EmergencyContactSerializer(BaseEmergencyContactSerializer):
    pass  

class UpdateEmergencyContactSerializer(BaseEmergencyContactSerializer):
    class Meta(BaseEmergencyContactSerializer.Meta):
        read_only_fields = ['id', 'deliverer']  
