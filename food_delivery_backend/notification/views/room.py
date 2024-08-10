from rest_framework import viewsets

from notification.models import DirectRoom, GroupRoom

from notification.serializers import DirectRoomSerializer, GroupRoomSerializer, DirectMessageSerializer

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin

class DirectRoomViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = DirectRoom.objects.all()
    serializer_class = DirectRoomSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'messages': DirectMessageSerializer
    }

    def get_object(self):
        queryset = super().get_object()
        if self.action == 'messages':
            return queryset.order_by('-created_at')
        return queryset

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == 'list':
            context.update({'detail': False})
        return context

class GroupRoomViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = GroupRoom.objects.all()
    serializer_class = GroupRoomSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'messages': DirectMessageSerializer
    }

    