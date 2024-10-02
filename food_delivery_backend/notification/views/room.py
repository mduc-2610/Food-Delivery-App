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

    def check_fk_query(self):
        query_params = self.request.query_params
        user1 = query_params.get('user1', None)
        user2 = query_params.get('user2', None)
        if user1 and user2:
            return [True, user1, user2]
        return [False, user1, user2]

    def get_queryset(self):
        check, user1, user2 = self.check_fk_query()        
        if user1 and user2:
            # try:
            #     queryset = DirectRoom.objects.filter(user1=user1, user2__deliverer=user2)            
            #     if not queryset.exists():
            #         queryset = DirectRoom.objects.filter(user1__deliverer=user2, user2=user1)
            #         return queryset
            # except:
            queryset = DirectRoom.objects.filter(user1=user1, user2=user2)       
            if not queryset.exists():
                queryset = DirectRoom.objects.filter(user1=user2, user2=user1)
                
            return queryset

        return super().get_queryset()

    def get_object(self):
        queryset = super().get_object()
        if self.action == 'messages':
            return queryset.order_by('-created_at')
        return queryset

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == 'list':
            context.update({'detail': False if not self.check_fk_query()[0] else True})
        return context

class GroupRoomViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = GroupRoom.objects.all()
    serializer_class = GroupRoomSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'messages': DirectMessageSerializer
    }

    