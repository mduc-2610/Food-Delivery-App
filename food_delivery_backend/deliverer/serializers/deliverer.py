# deliverer/serializers.py
from rest_framework import serializers

from deliverer.models import Deliverer

# from deliverer.serializers import (
#     BasicInfoSerializer, DriverLicenseSerializer, 
#     OtherInfoSerializer, AddressSerializer, OperationInfoSerializer, EmergencyContactSerializer)
from deliverer.serializers.basic_info import BasicInfoSerializer
from deliverer.serializers.residency_info import ResidencyInfoSerializer
from deliverer.serializers.driver_license import DriverLicenseSerializer
from deliverer.serializers.other_info import OtherInfoSerializer
from deliverer.serializers.address import AddressSerializer
from deliverer.serializers.operation_info import OperationInfoSerializer
from deliverer.serializers.emergency_contact import EmergencyContactSerializer

from utils.serializers import CustomRelatedModelSerializer

class DelivererSerializer(serializers.ModelSerializer):
    class Meta:
        model = Deliverer
        fields = ['id', 'user']
        
class DetailDelivererSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.one_related_serializer_class = {
            'basic_info': BasicInfoSerializer,
            'residency_info': ResidencyInfoSerializer,
            'driver_license': DriverLicenseSerializer,
            'other_info': OtherInfoSerializer,
            'address': AddressSerializer,
            'operation_info': OperationInfoSerializer,
            'emergency_contact': EmergencyContactSerializer,
        }
    
    class Meta:
        model = Deliverer
        fields = (
            'id',
        )
        depth = 2