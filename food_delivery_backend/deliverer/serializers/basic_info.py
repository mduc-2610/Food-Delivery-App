# basicinfo/serializers.py
from rest_framework import serializers
from deliverer.models import BasicInfo

class BaseBasicInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = BasicInfo
        fields = [
            'id', 
            'deliverer',
            'full_name',
            'given_name',
            'gender',
            'date_of_birth',
            'hometown',
            'city',
            'district',
            'ward',
            'address',
            'citizen_identification',
        ]
        read_only_fields = ['id']

class BasicInfoSerializer(BaseBasicInfoSerializer):
    pass  

class UpdateBasicInfoSerializer(BaseBasicInfoSerializer):
    class Meta(BaseBasicInfoSerializer.Meta):
        read_only_fields = ['id', 'deliverer']  
