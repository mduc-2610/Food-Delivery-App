from rest_framework import viewsets

from notification.models import DirectRoom, GroupRoom

from notification.serializers import DirectRoomSerializer, GroupRoomSerializer

from utils.pagination import CustomPagination

class DirectRoomViewSet(viewsets.ModelViewSet):
    queryset = DirectRoom.objects.all()
    serializer_class = DirectRoomSerializer
    pagination_class = CustomPagination


class GroupRoomViewSet(viewsets.ModelViewSet):
    queryset = GroupRoom.objects.all()
    serializer_class = GroupRoomSerializer
    pagination_class = CustomPagination

