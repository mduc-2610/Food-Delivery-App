from rest_framework import serializers

from deliverer.models import Deliverer

class BasicDelivererSerializer(serializers.ModelSerializer):
    class Meta:
        model = Deliverer
        fields = [
            'id', 
            'basic_info', 
            'rating', 
            'total_reviews', 
            'avatar'
        ]
        depth = 1