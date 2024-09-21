# address/serializers.py
from rest_framework import serializers
from deliverer.models import Address

class BaseAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = [
            'id', 
            'deliverer', 
            'city', 
            'district', 
            'ward', 
            'detail_address'
        ]
        read_only_fields = ['id']

class AddressSerializer(BaseAddressSerializer):
    deliverer = serializers.PrimaryKeyRelatedField(queryset=Address.objects.all())

class UpdateAddressSerializer(BaseAddressSerializer):
    class Meta(BaseAddressSerializer.Meta):
        read_only_fields = ['id', 'deliverer']  
