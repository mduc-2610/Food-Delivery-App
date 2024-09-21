from rest_framework import serializers
from deliverer.models import ResidencyInfo

class BaseResidencyInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ResidencyInfo
        fields = [
            'id',
            'deliverer',
            'is_same_as_ci',
            'city',
            'district',
            'ward',
            'address',
            'tax_code',
            'email',
        ]
        read_only_fields = ['id']

class ResidencyInfoSerializer(BaseResidencyInfoSerializer):
    pass  

class UpdateResidencyInfoSerializer(BaseResidencyInfoSerializer):
    class Meta(BaseResidencyInfoSerializer.Meta):
        read_only_fields = ['id', 'deliverer']  
