# representatives/serializers.py
from rest_framework import serializers
from restaurant.models import Representative

class BasicRepresentativeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Representative
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

class RepresentativeSerializer(BasicRepresentativeSerializer):
    pass

class UpdateRepresentativeSerializer(BasicRepresentativeSerializer):
    class Meta(BasicRepresentativeSerializer.Meta):
        read_only_fields = ['id', 'restaurant']
