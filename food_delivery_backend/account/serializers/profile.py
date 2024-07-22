from rest_framework import serializers
from account.models import Profile, Location

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['id', 'address', 'latitude', 'longitude']

class ProfileSerializer(serializers.ModelSerializer):
    locations = LocationSerializer(many=True, read_only=True)

    class Meta:
        model = Profile
        fields = ['id', 'user', 'name', 'gender', 'date_of_birth', 'locations']
