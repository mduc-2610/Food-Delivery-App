# deliverer/serializers.py
from rest_framework import serializers
from deliverer.models import DriverLicense

class BaseDriverLicenseSerializer(serializers.ModelSerializer):
    class Meta:
        model = DriverLicense
        fields = [
            'id',
            'deliverer', 
            'driver_license_front', 
            'driver_license_back', 
            'vehicle_type', 
            'license_plate', 
            'motorcycle_registration_certificate_front',
            'motorcycle_registration_certificate_back'
        ]
        read_only_fields = ['id']

class DriverLicenseSerializer(BaseDriverLicenseSerializer):
    pass  

class UpdateDriverLicenseSerializer(BaseDriverLicenseSerializer):
    class Meta(BaseDriverLicenseSerializer.Meta):
        read_only_fields = ['id', 'deliverer']  
