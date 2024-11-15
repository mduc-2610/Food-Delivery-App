# order/views.py
from rest_framework import viewsets, response, status
from rest_framework.decorators import action

from order.models import Order, OrderCancellation

from order.serializers import OrderSerializer, CreateOrderSerializer

from order.serializers import (
    DeliverySerializer, 
    DeliveryRequestSerializer,
    DetailOrderSerializer,
    UpdateOrderSerializer,
    OrderCancellationSerializer, 
    RestaurantPromotionSerializer,
)
from deliverer.serializers import BasicDelivererSerializer

from utils.mixins import DefaultGenericMixin, DynamicFilterMixin
from utils.pagination import CustomPagination
from utils.views import (
    OneRelatedViewSet,
    ManyRelatedViewSet,
)

class OrderViewSet(DefaultGenericMixin, DynamicFilterMixin, ManyRelatedViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    pagination_class =  CustomPagination
    mapping_serializer_class = {
        'retrieve': DetailOrderSerializer,
        'create': CreateOrderSerializer,
        'update': UpdateOrderSerializer,
    }
    many_related_serializer_class = {
        'restaurant_promotions': RestaurantPromotionSerializer,
    }

    def get_pagination_class(self):
        return super().get_pagination_class()

    def get_object(self):
        if self.action == 'retrieve':
            return OneRelatedViewSet.get_object(self)
        return super().get_object()

    # def get_queryset(self):
    #     status = self.request.query_params.get('status', None)
    #     queryset = super().get_queryset()
    #     if status:
    #         queryset = queryset.exclude(status=status)
    #     return queryset

    @action(detail=True, methods=['POST'], url_path='create-delivery-and-request')
    def create_delivery_and_request(self, request, pk=None):
        order = self.get_object()
        result = order.create_delivery_and_request()
        if result:
            delivery_request, nearest_deliverer = result
            context = self.get_serializer_context()

            return response.Response({
                'delivery_request': DeliveryRequestSerializer(delivery_request, context=context).data,
                'nearest_deliverer': BasicDelivererSerializer(nearest_deliverer).data if nearest_deliverer else None
            }, status=status.HTTP_201_CREATED)
        return response.Response({
            'message': "No delivery request created"
        }, status=status.HTTP_400_BAD_REQUEST)

class OrderCancellationViewSet(DefaultGenericMixin, OneRelatedViewSet, viewsets.ModelViewSet):
    queryset = OrderCancellation.objects.all()
    serializer_class = OrderCancellationSerializer
    pagination_class =  CustomPagination
    mapping_serializer_class = {
        'create': OrderCancellationSerializer,
    }