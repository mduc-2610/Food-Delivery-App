from rest_framework import viewsets, exceptions, mixins

from food.models import DishLike

from food.serializers import DishLikeSerializer, CreateDishLikeSerializer

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin


class DishLikeViewSet(mixins.ListModelMixin,
                      mixins.CreateModelMixin,
                      mixins.RetrieveModelMixin,
                      DefaultGenericMixin,
                      viewsets.GenericViewSet):
    
    queryset = DishLike.objects.all()
    serializer_class = DishLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateDishLikeSerializer
    }