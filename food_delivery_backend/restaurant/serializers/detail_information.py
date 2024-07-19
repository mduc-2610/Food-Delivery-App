# detailinformation/serializers.py
from rest_framework import serializers
from restaurant.models import DetailInformation

class DetailInformationSerializer(serializers.ModelSerializer):
    class Meta:
        model = DetailInformation
        fields = [
            'id', 'opening_hours', 'keywords', 'description', 'avatar_image', 
            'cover_image', 'facade_image', 'restaurant_type', 'cuisine', 
            'specialty_dishes', 'serving_times', 'target_audience', 
            'restaurant_category', 'purpose'
        ]
