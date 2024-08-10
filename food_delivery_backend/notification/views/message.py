from rest_framework import viewsets

from notification.models import (
    DirectMessage, GroupMessage,
    DirectImageMessage, DirectVideoMessage, 
    GroupImageMessage, GroupVideoMessage
)

from notification.serializers import (
    DirectMessageSerializer, GroupMessageSerializer,
    DirectImageMessageSerializer, DirectVideoMessageSerializer, 
    GroupImageMessageSerializer, GroupVideoMessageSerializer,
    CreateDirectMessageSerializer
)

from utils.pagination import CustomPagination
from utils.mixins import DefaultGenericMixin

class DirectImageMessageViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DirectImageMessage.objects.all()
    serializer_class = DirectImageMessageSerializer
    pagination_class = CustomPagination

    # def get_queryset(self):
        
    #     return super().get_queryset().order_by('-message__created_at')

class DirectVideoMessageViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DirectVideoMessage.objects.all()
    serializer_class = DirectVideoMessageSerializer
    pagination_class = CustomPagination
    

    def perform_create(self, serializer):
        serializer.save()

class GroupImageMessageViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = GroupImageMessage.objects.all()
    serializer_class = GroupImageMessageSerializer
    pagination_class = CustomPagination
    

    def perform_create(self, serializer):
        serializer.save()

class GroupVideoMessageViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = GroupVideoMessage.objects.all()
    serializer_class = GroupVideoMessageSerializer
    pagination_class = CustomPagination
    

    def perform_create(self, serializer):
        serializer.save()
        
class DirectMessageViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DirectMessage.objects.all()
    serializer_class = DirectMessageSerializer
    pagination_class = CustomPagination
    
    def get_queryset(self):
        
        return super().get_queryset().order_by('-created_at')
    
    def get_serializer_class(self):
        if self.action == 'create':
            return CreateDirectMessageSerializer
        return super().get_serializer_class()
        

    # def perform_create(self, serializer):
    #     serializer.save()

class GroupMessageViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = GroupMessage.objects.all()
    serializer_class = GroupMessageSerializer
    pagination_class = CustomPagination

    # def perform_create(self, serializer):
    #     serializer.save()
