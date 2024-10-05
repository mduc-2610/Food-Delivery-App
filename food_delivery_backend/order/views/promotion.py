from rest_framework import viewsets

from order.models import (
    RestaurantPromotion,
    # ActivityPromotion,
)

from order.serializers import (
    RestaurantPromotionSerializer,
    CreateRestaurantPromotionSerializer,
    # ActivityPromotionSerializer,
)

from utils.pagination import CustomPagination
from utils.mixins import DefaultGenericMixin

class RestaurantPromotionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = RestaurantPromotion.objects.all()
    serializer_class = RestaurantPromotionSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateRestaurantPromotionSerializer,
    }

# class ActivityPromotionViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
#     queryset = ActivityPromotion.objects.all()
#     serializer_class = ActivityPromotionSerializer
