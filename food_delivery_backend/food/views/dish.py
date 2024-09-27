from rest_framework import (
    response, 
    viewsets, 
    status,
    mixins,
)
from rest_framework.decorators import action

from food.models import (
    Dish,
    DishImage
)

from account.serializers import BasicUserSerializer
from food.serializers import (
    DishSerializer, 
    DetailDishSerializer, 
    CreateUpdateDishSerializer,

    DishImageSerializer,
    DishLikeSerializer,
    DishInCartOrOrderSerializer
)
from review.serializers import (
    DishReviewSerializer,
    DishReviewLikeSerializer,
)
from review.mixins import ReviewFilterMixin
from utils.views import ManyRelatedViewSet
from utils.pagination import CustomPagination
from utils.mixins import DefaultGenericMixin

class DishPagination(CustomPagination):
    def __init__(self):
        super().__init__()
        self.page_size_query_param = 'dish_page_size'

class DishViewSet(DefaultGenericMixin, ManyRelatedViewSet, ReviewFilterMixin):
    queryset = Dish.objects.all()
    serializer_class = DishSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'retrieve': DetailDishSerializer,
        'create': CreateUpdateDishSerializer,
        'update': CreateUpdateDishSerializer,
        'liked_by_users': BasicUserSerializer,
        'reviewed_by_users': BasicUserSerializer,
        'likes': DishLikeSerializer,
        'dish_reviews': DishReviewSerializer,
        'in_carts_or_orders': DishInCartOrOrderSerializer,
    }   
    # many_related = {
    #     'liked_by_users': {
    #         'action': (['GET'], 'liked-by-users'),
    #         'queryset': lambda instance: instance.liked_by_users.all(),
    #         'serializer_class': UserAbbrSerializer,
    #     },
    #     'reviewed_by_users': {
    #         'action': (['GET'], 'reviewed-by-users'),
    #         'queryset': lambda instance: instance.reviewed_by_users.all(),
    #         'serializer_class': UserAbbrSerializer,
    #     }
    # }

    def get_object(self):
        if self.action == 'dish_reviews':
            return ReviewFilterMixin.get_object(self)
        return super().get_object()
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "liked_by_users" or self.action == "reviewed_by_users":
            context.update({"many": True})
        return context

class DishImageViewSet(
    DefaultGenericMixin, 
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin, 
    mixins.CreateModelMixin, 
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet,
):
    queryset = DishImage.objects.all()
    serializer_class = DishImageSerializer
    pagination_class = CustomPagination
    