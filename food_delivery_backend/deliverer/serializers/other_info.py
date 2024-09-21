from rest_framework import serializers
from deliverer.models import OtherInfo

class BaseOtherInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = OtherInfo
        fields = [
            'id',
            'deliverer',
            'occupation',
            'details',
            'judicial_record',
        ]
        read_only_fields = ['id']

class OtherInfoSerializer(BaseOtherInfoSerializer):
    pass  

class UpdateOtherInfoSerializer(BaseOtherInfoSerializer):
    class Meta(BaseOtherInfoSerializer.Meta):
        read_only_fields = ['id', 'deliverer']  
