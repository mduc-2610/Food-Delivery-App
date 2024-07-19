# basicinfo/serializers.py
from rest_framework import serializers
from restaurant.models import BasicInfo

class BasicInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = BasicInfo
        fields = ['id', 'name', 'phone_number', 'city', 'district', 'street_address', 'map_location']
