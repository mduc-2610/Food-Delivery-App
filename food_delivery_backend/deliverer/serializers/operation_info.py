from rest_framework import serializers
from deliverer.models import OperationInfo

class BaseOperationInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = OperationInfo
        fields = [
            'id',
            'deliverer',
            'city',
            'driver_type',
            'area',
            'time',
            'hub',
        ]
        read_only_fields = ['id']

class OperationInfoSerializer(BaseOperationInfoSerializer):
    pass  

class UpdateOperationInfoSerializer(BaseOperationInfoSerializer):
    class Meta(BaseOperationInfoSerializer.Meta):
        read_only_fields = ['id', 'deliverer']  
