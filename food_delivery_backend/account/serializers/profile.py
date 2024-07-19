# profiles/serializers.py
from rest_framework import serializers
from account.models import Profile

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ['user', 'name', 'gender', 'location', 'date_of_birth']
