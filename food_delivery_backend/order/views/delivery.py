# delivery/views.py
from rest_framework import viewsets, response, status
from rest_framework.decorators import action
from order.models import (
    Delivery, 
    DeliveryRequest
)

from order.serializers import (
    DeliverySerializer, 
    DeliveryRequestSerializer
)

from utils.mixins import DefaultGenericMixin
from utils.views import ManyRelatedViewSet, OneRelatedViewSet
from utils.pagination import CustomPagination

class DeliveryViewSet(DefaultGenericMixin, OneRelatedViewSet, ManyRelatedViewSet):
    queryset = Delivery.objects.all()
    serializer_class = DeliverySerializer
    many_related_serializer_class = {
        'requests': DeliveryRequestSerializer
    }

class DeliveryRequestViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = DeliveryRequest.objects.all()
    serializer_class = DeliveryRequestSerializer
    # pagination_class = CustomPagination
    mapping_serializer_class = {
        ('accept', 'decline'): DeliveryRequestSerializer,
    }

    def handle_action(self, action_name, *args, **kwargs):
        obj = self.get_object()
        getattr(obj, action_name)()  
        serializer = self.get_serializer(obj)
        return response.Response(serializer.data, status=status.HTTP_200_OK)

    @action(detail=True, methods=['POST'], url_path='accept')
    def accept(self, request, *args, **kwargs):
        return self.handle_action('accept', *args, **kwargs)

    @action(detail=True, methods=['POST'], url_path='decline')
    def decline(self, request, *args, **kwargs):
        return self.handle_action('decline', *args, **kwargs)

    @action(detail=True, methods=['POST'], url_path='expire')
    def expire(self, request, *args, **kwargs):
        return self.handle_action('expire', *args, **kwargs)