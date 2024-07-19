# operating_hours/serializers.py
from rest_framework import serializers
from restaurant.models import OperatingHour

class OperatingHourSerializer(serializers.ModelSerializer):
    class Meta:
        model = OperatingHour
        fields = ['id', 'day_of_week', 'open_time', 'close_time', 'detail_information']
