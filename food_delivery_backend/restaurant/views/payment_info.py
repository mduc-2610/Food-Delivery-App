from rest_framework import viewsets

from restaurant.models import PaymentInfo

from restaurant.serializers import (
    PaymentInfoSerializer,
    UpdatePaymentInfoSerializer
)

from utils.views import OneRelatedViewSet

from utils.mixins import DefaultGenericMixin

class PaymentInfoViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = PaymentInfo.objects.all()
    serializer_class = PaymentInfoSerializer
    mapping_serializer_class = {
        'update': UpdatePaymentInfoSerializer,
    }