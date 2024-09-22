# representatives/serializers.py
from rest_framework import serializers
from restaurant.models import RepresentativeInfo

class BasicRepresentativeInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = RepresentativeInfo
        fields = [
            'id', 
            'restaurant', 
            'registration_type',
            'full_name',
            'email',
            'phone_number',
            'other_phone_number',
            'citizen_identification',
            'tax_code',
            'citizen_identification_front',
            'citizen_identification_back',
            'business_registration_image'
        ]
        read_only_fields = ['id']

class RepresentativeInfoSerializer(BasicRepresentativeInfoSerializer):
    pass

class UpdateRepresentativeInfoSerializer(BasicRepresentativeInfoSerializer):
    class Meta(BasicRepresentativeInfoSerializer.Meta):
        read_only_fields = ['id', 'restaurant']
