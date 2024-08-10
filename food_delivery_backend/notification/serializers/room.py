from rest_framework import serializers

from notification.models import DirectRoom, GroupRoom

from notification.serializers import DirectMessageSerializer, GroupMessageSerializer
from utils.serializers import CustomRelatedModelSerializer

class DirectRoomSerializer(CustomRelatedModelSerializer):
    latest_message = DirectMessageSerializer()
    name = serializers.SerializerMethodField()

    def get_name(self, obj):
        return obj.name.split('-')[-1].strip()
    class Meta:
        model = DirectRoom
        fields = '__all__'

class GroupRoomSerializer(CustomRelatedModelSerializer):
    latest_message = DirectMessageSerializer()

    class Meta:
        model = GroupRoom
        fields = '__all__'
