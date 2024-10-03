# basicinfo/serializers.py
from rest_framework import serializers
from deliverer.models import BasicInfo

class BaseBasicInfoSerializer(serializers.ModelSerializer):
    gender = serializers.CharField(source="get_gender_display")
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

    def to_representation(self, instance):
        data = super().to_representation(instance)
        print(data, pretty=True)
        return data

class UpdateBasicInfoSerializer(BaseBasicInfoSerializer):
    class Meta(BaseBasicInfoSerializer.Meta):
        read_only_fields = ['id', 'deliverer']  
