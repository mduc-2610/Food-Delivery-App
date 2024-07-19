# promotion/views.py
from rest_framework import viewsets
from order.models import Promotion, ActivityPromotion
from order.serializers import PromotionSerializer, ActivityPromotionSerializer

class PromotionViewSet(viewsets.ModelViewSet):
    queryset = Promotion.objects.all()
    serializer_class = PromotionSerializer

class ActivityPromotionViewSet(viewsets.ModelViewSet):
    queryset = ActivityPromotion.objects.all()
    serializer_class = ActivityPromotionSerializer
