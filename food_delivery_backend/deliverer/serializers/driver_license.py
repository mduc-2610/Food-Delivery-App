# deliverer/serializers.py
from rest_framework import serializers
from deliverer.models import DriverLicense

class DriverLicenseSerializer(serializers.ModelSerializer):
    class Meta:
        model = DriverLicense
        fields = ['id', 'license_front', 'license_back', 'vehicle_type', 'license_plate', 'registration_certificate']
