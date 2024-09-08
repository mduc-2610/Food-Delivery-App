# order/views.py
from rest_framework import viewsets, response
from rest_framework.decorators import action

from order.models import Order, OrderCancellation

from order.serializers import OrderSerializer, CreateOrderSerializer

from order.serializers import DeliverySerializer, OrderCancellationSerializer
from deliverer.serializers import BasicDelivererSerializer

from utils.mixins import DefaultGenericMixin
from utils.pagination import CustomPagination
from utils.views import OneRelatedViewSet

class OrderViewSet(DefaultGenericMixin, OneRelatedViewSet, viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    pagination_class =  CustomPagination
    mapping_serializer_class = {
        'create': CreateOrderSerializer,
    }

    @action(detail=True, methods=['POST'], url_path='create-delivery-and-request')
    def create_delivery_and_request(self, request, pk=None):
        order = self.get_object()
        delivery, nearest_deliverer = order.create_delivery_and_request()
        context = self.get_serializer_context()

        return response.Response({
            'delivery': DeliverySerializer(delivery, context=context).data,
            'nearest_deliverer': BasicDelivererSerializer(nearest_deliverer).data if nearest_deliverer else None
        })

class OrderCancellationViewSet(DefaultGenericMixin, OneRelatedViewSet, viewsets.ModelViewSet):
    queryset = OrderCancellation.objects.all()
    serializer_class = OrderCancellationSerializer
    pagination_class =  CustomPagination
    mapping_serializer_class = {
        'create': OrderCancellationSerializer,
    }