# reviews/views.py
from rest_framework import viewsets

from review.models import (
    DishReviewReply, DelivererReviewReply, 
    RestaurantReviewReply, DeliveryReviewReply
)

from account.serializers import BasicUserSerializer
from review.serializers import (
    DishReviewReplySerializer, DelivererReviewReplySerializer, 
    RestaurantReviewReplySerializer, DeliveryReviewReplySerializer,

    CreateUpdateDelivererReviewReplySerializer, CreateUpdateDishReviewReplySerializer, 
    CreateUpdateDeliveryReviewReplySerializer, CreateUpdateRestaurantReviewReplySerializer,

)

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import (
    DefaultGenericMixin,
    ForeignKeyFilterMixin,
)

class DishReviewReplyViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = DishReviewReply.objects.all()
    serializer_class = DishReviewReplySerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        # 'liked_by_users': UserAbbrSerializer,
        'update': CreateUpdateDishReviewReplySerializer,
        'create': CreateUpdateDishReviewReplySerializer,
    }

class DelivererReviewReplyViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = DelivererReviewReply.objects.all()
    serializer_class = DelivererReviewReplySerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'update': CreateUpdateDelivererReviewReplySerializer,
        'create': CreateUpdateDelivererReviewReplySerializer,
    }

class RestaurantReviewReplyViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = RestaurantReviewReply.objects.all()
    serializer_class = RestaurantReviewReplySerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'update': CreateUpdateRestaurantReviewReplySerializer,
        'create': CreateUpdateRestaurantReviewReplySerializer,
    }

class DeliveryReviewReplyViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = DeliveryReviewReply.objects.all()
    serializer_class = DeliveryReviewReplySerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'update': CreateUpdateDeliveryReviewReplySerializer,
        'create': CreateUpdateDeliveryReviewReplySerializer,
    }

