# basicinfo/serializers.py
from rest_framework import serializers
from deliverer.models import BasicInfo

class BasicInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = BasicInfo
        fields = ['id', 'deliverer', 'full_name', 'given_name', 'gender', 'date_of_birth', 'hometown', 'city', 'district', 'ward', 'address', 'citizen_identification']
