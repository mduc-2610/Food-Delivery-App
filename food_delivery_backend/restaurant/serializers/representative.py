# representatives/serializers.py
from rest_framework import serializers
from restaurant.models import Representative

class RepresentativeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Representative
        fields = ['id', 'restaurant', 'registration_type', 'full_name', 'email', 'phone_number', 'other_phone_number', 
                  'id_front_image', 'id_back_image', 'business_registration_image']
