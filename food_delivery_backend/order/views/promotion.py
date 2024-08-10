from rest_framework import viewsets

from order.models import Promotion, ActivityPromotion

from order.serializers import PromotionSerializer, ActivityPromotionSerializer

from utils.mixins import DefaultGenericMixin

class PromotionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = Promotion.objects.all()
    serializer_class = PromotionSerializer

class ActivityPromotionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = ActivityPromotion.objects.all()
    serializer_class = ActivityPromotionSerializer
