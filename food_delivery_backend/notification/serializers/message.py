from rest_framework import serializers
from notification.models import DirectMessage, GroupMessage, DirectImageMessage, DirectVideoMessage, GroupImageMessage, GroupVideoMessage

class DirectImageMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = DirectImageMessage
        fields = '__all__'

class DirectVideoMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = DirectVideoMessage
        fields = '__all__'

class GroupImageMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = GroupImageMessage
        fields = '__all__'

class GroupVideoMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = GroupVideoMessage
        fields = '__all__'

class DirectMessageSerializer(serializers.ModelSerializer):
    image_message = DirectImageMessageSerializer(read_only=True)
    video_message = DirectVideoMessageSerializer(read_only=True)

    class Meta:
        model = DirectMessage
        fields = '__all__'

class GroupMessageSerializer(serializers.ModelSerializer):
    image_message = GroupImageMessageSerializer(read_only=True)
    video_message = GroupVideoMessageSerializer(read_only=True)

    class Meta:
        model = GroupMessage
        fields = '__all__'
