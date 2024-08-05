# basicinfo/serializers.py
from rest_framework import serializers
from restaurant.models import BasicInfo, Restaurant

class BasicInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = BasicInfo
        fields = ['id', 'restaurant', 'name', 'phone_number', 'city', 'district', 'street_address', 'latitude', 'longitude']
