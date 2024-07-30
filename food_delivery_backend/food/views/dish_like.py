from rest_framework import viewsets, exceptions, mixins

from food.models import DishLike

from food.serializers import DishLikeSerializer, CreateDishLikeSerializer

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet


class DishLikeViewSet(mixins.ListModelMixin,
                      mixins.CreateModelMixin,
                      mixins.RetrieveModelMixin,
                      viewsets.GenericViewSet):
    
    queryset = DishLike.objects.all()
    serializer_class = DishLikeSerializer
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'create': CreateDishLikeSerializer
    }