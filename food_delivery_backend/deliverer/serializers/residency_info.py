# deliverer/serializers.py
from rest_framework import serializers
from deliverer.models import ResidencyInfo

class ResidencyInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ResidencyInfo
        fields = ['id', 'deliverer', 'is_same_as_ci', 'city', 'district', 'ward', 'address', 'tax_code', 'email', 'basic_info']
