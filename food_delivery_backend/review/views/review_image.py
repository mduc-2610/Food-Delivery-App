from rest_framework import viewsets

from review.models import (
    DishReview, DelivererReview, 
    RestaurantReview, DeliveryReview
)

from account.serializers import BasicUserSerializer
from review.serializers import (
    ReviewImageSerializer,
    CreateReviewImageSerializer
)

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import (
    DefaultGenericMixin,
    ForeignKeyFilterMixin,
)

class ReviewImageViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = DishReview.objects.all()
    serializer_class = ReviewImageSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        # 'liked_by_users': UserAbbrSerializer,
        'create': CreateReviewImageSerializer,
    }