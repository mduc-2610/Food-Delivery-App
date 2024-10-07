# basicinfo/serializers.py
from rest_framework import serializers
from restaurant.models import BasicInfo

class BaseBasicInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = BasicInfo
        fields = [
            'id', 
            'restaurant', 
            'name', 
            'phone_number', 
            'city', 
            'district', 
            'address', 
            'address_name', 
            'latitude', 
            'longitude'
        ]
        read_only_fields = ['id']

class BasicInfoSerializer(BaseBasicInfoSerializer):
    class Meta(BaseBasicInfoSerializer.Meta):
        pass  

class UpdateBasicInfoSerializer(BaseBasicInfoSerializer):
    class Meta(BaseBasicInfoSerializer.Meta):
        read_only_fields = ['id', 'restaurant']   

