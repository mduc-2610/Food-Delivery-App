from rest_framework import serializers
from account.models import Profile, UserLocation

class ProfileSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Profile
        fields = ['id', 'user', 'name', 'avatar', 'gender', 'date_of_birth']
        extra_kwargs = {
            'id': {'read_only': True},
            'user': {'read_only': True},
        }
