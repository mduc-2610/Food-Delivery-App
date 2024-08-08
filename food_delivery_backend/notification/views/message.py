from rest_framework import viewsets

from notification.models import (
    DirectMessage, GroupMessage,
    DirectImageMessage, DirectVideoMessage, 
    GroupImageMessage, GroupVideoMessage
)

from notification.serializers import (
    DirectMessageSerializer, GroupMessageSerializer,
    DirectImageMessageSerializer, DirectVideoMessageSerializer, 
    GroupImageMessageSerializer, GroupVideoMessageSerializer
)

from utils.pagination import CustomPagination

class DirectImageMessageViewSet(viewsets.ModelViewSet):
    queryset = DirectImageMessage.objects.all()
    serializer_class = DirectImageMessageSerializer
    pagination_class = CustomPagination

    def perform_create(self, serializer):
        serializer.save()

class DirectVideoMessageViewSet(viewsets.ModelViewSet):
    queryset = DirectVideoMessage.objects.all()
    serializer_class = DirectVideoMessageSerializer
    pagination_class = CustomPagination
    

    def perform_create(self, serializer):
        serializer.save()

class GroupImageMessageViewSet(viewsets.ModelViewSet):
    queryset = GroupImageMessage.objects.all()
    serializer_class = GroupImageMessageSerializer
    pagination_class = CustomPagination
    

    def perform_create(self, serializer):
        serializer.save()

class GroupVideoMessageViewSet(viewsets.ModelViewSet):
    queryset = GroupVideoMessage.objects.all()
    serializer_class = GroupVideoMessageSerializer
    pagination_class = CustomPagination
    

    def perform_create(self, serializer):
        serializer.save()
        
class DirectMessageViewSet(viewsets.ModelViewSet):
    queryset = DirectMessage.objects.all()
    serializer_class = DirectMessageSerializer
    pagination_class = CustomPagination

    # def perform_create(self, serializer):
    #     serializer.save()

class GroupMessageViewSet(viewsets.ModelViewSet):
    queryset = GroupMessage.objects.all()
    serializer_class = GroupMessageSerializer
    pagination_class = CustomPagination

    # def perform_create(self, serializer):
    #     serializer.save()
