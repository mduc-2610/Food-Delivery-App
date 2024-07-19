# messaging/serializers.py
from rest_framework import serializers
from notification.models import Message, ImageMessage, AudioMessage, LocationMessage

class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['id', 'sender', 'receiver', 'message_type', 'content', 'timestamp', 'read_status']

class ImageMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ImageMessage
        fields = ['id', 'message', 'image']

class AudioMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = AudioMessage
        fields = ['id', 'message', 'audio']

class LocationMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = LocationMessage
        fields = ['id', 'message', 'latitude', 'longitude']
