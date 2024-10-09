from rest_framework import serializers

from notification.models import (
    DirectMessage,
    GroupMessage,
    DirectImageMessage,
    DirectVideoMessage,
    GroupImageMessage,
    GroupVideoMessage,
)
from account.serializers import BasicUserSerializer

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
    images = DirectImageMessageSerializer(read_only=True, many=True)
    videos = DirectVideoMessageSerializer(read_only=True, many=True)
    user = BasicUserSerializer(read_only=True, required=False)
    
    class Meta:
        model = DirectMessage
        fields = '__all__'

class CreateDirectMessageSerializer(serializers.ModelSerializer):
    images = serializers.ListField(
        child=serializers.ImageField(),
        write_only=True,
        required=False
    )
    videos = serializers.ListField(
        child=serializers.FileField(),
        write_only=True,
        required=False
    )

    def validate(self, attrs):
        content = attrs.get('content')
        images = attrs.get('images', [])
        videos = attrs.get('videos', [])
        latitude = attrs.get('latitude')
        longitude = attrs.get('longitude')

        if not content and not images and not videos and not (latitude and longitude):
            raise serializers.ValidationError("Content cannot be empty if no image, video, or location is provided.")

        return super().validate(attrs)
    
    class Meta:
        model = DirectMessage
        fields = ['id', 'content', 'latitude', 'longitude', 'images', 'videos', 'user', 'room']

    def create(self, validated_data):
        images_data = validated_data.pop('images', [])
        videos_data = validated_data.pop('videos', [])
        
        direct_message = DirectMessage.objects.create(**validated_data)

        for image in images_data:
            image_instance = DirectImageMessage.objects.create(image=image, message=direct_message)

        for video in videos_data:
            video_instance = DirectVideoMessage.objects.create(video=video, message=direct_message)

        return direct_message
    
    def to_representation(self, instance):
        return DirectMessageSerializer(instance, context=self.context).data

class GroupMessageSerializer(serializers.ModelSerializer):
    images = GroupImageMessageSerializer(read_only=True, many=True)
    videos = GroupVideoMessageSerializer(read_only=True, many=True)
    user = BasicUserSerializer(read_only=True, required=False)


    class Meta:
        model = GroupMessage
        fields = '__all__'
