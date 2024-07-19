# deliverer/serializers.py
from rest_framework import serializers
from deliverer.models import Deliverer, BasicInfo, ResidencyInfo, DriverLicense, OtherInfo, Address, OperationInfo, EmergencyContact

class BasicInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = BasicInfo
        fields = '__all__'

class ResidencyInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ResidencyInfo
        fields = '__all__'

class DriverLicenseSerializer(serializers.ModelSerializer):
    class Meta:
        model = DriverLicense
        fields = '__all__'

class OtherInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = OtherInfo
        fields = '__all__'

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = '__all__'

class OperationInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = OperationInfo
        fields = '__all__'

class EmergencyContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmergencyContact
        fields = '__all__'

class DelivererSerializer(serializers.ModelSerializer):
    basic_info = BasicInfoSerializer()
    residency_info = ResidencyInfoSerializer()
    driver_license_and_vehicle = DriverLicenseSerializer()
    other_info = OtherInfoSerializer()
    address = AddressSerializer()
    operation_info = OperationInfoSerializer()
    emergency_contact = EmergencyContactSerializer()

    class Meta:
        model = Deliverer
        fields = ['id', 'user', 'basic_info', 'residency_info', 'driver_license_and_vehicle', 'other_info', 'address', 'operation_info', 'emergency_contact']
