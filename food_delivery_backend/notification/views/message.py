# messaging/views.py
from rest_framework import viewsets
from notification.models import Message, ImageMessage, AudioMessage, LocationMessage
from notification.serializers import MessageSerializer, ImageMessageSerializer, AudioMessageSerializer, LocationMessageSerializer

class MessageViewSet(viewsets.ModelViewSet):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer

class ImageMessageViewSet(viewsets.ModelViewSet):
    queryset = ImageMessage.objects.all()
    serializer_class = ImageMessageSerializer

class AudioMessageViewSet(viewsets.ModelViewSet):
    queryset = AudioMessage.objects.all()
    serializer_class = AudioMessageSerializer

class LocationMessageViewSet(viewsets.ModelViewSet):
    queryset = LocationMessage.objects.all()
    serializer_class = LocationMessageSerializer
