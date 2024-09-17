# deliverer/serializers.py
from rest_framework import serializers
from deliverer.models import DriverLicense

class DriverLicenseSerializer(serializers.ModelSerializer):
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
