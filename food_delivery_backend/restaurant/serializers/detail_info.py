# detailinformation/serializers.py
from rest_framework import serializers
from restaurant.models import DetailInfo

class DetailInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = DetailInfo
        fields = [
            'id', 'restaurant', 'keywords', 'description', 'avatar_image', 
            'cover_image', 'facade_image', 'restaurant_type', 'cuisine', 
            'specialty_dishes', 'serving_times', 'target_audience', 
            'purpose'
        ]
