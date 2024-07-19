# addresses/serializers.py
from rest_framework import serializers
from deliverer.models import Address

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = ['id', 'city', 'district', 'ward', 'detail_address']
