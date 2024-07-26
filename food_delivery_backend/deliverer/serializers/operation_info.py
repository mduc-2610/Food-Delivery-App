# deliverer/serializers.py
from rest_framework import serializers
from deliverer.models import OperationInfo

class OperationInfoSerializer(serializers.ModelSerializer):

    class Meta:
        model = OperationInfo
        fields = ['id', 'deliverer', 'city', 'operation_type', 'operational_area', 'operational_time']
