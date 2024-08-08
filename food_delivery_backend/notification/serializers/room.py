from rest_framework import serializers
from notification.models import DirectRoom, GroupRoom

class DirectRoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = DirectRoom
        fields = '__all__'

class GroupRoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = GroupRoom
        fields = '__all__'
