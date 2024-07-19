# deliverer/serializers.py
from rest_framework import serializers
from deliverer.models import OtherInfo

class OtherInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = OtherInfo
        fields = ['id', 'occupation', 'details', 'judicial_record']
