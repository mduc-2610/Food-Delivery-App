# order/views.py
from rest_framework import viewsets

from order.models import Order

from order.serializers import OrderSerializer, CreateOrderSerializer

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