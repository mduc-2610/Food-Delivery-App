from rest_framework import (
    response, viewsets, status
)
from rest_framework.decorators import action

from food.models import Dish

from account.serializers import UserAbbrSerializer
from food.serializers import DishSerializer, DetailDishSerializer, DishLikeSerializer
from review.serializers import DishReviewSerializer, DishReviewLikeSerializer

from utils.views import ManyRelatedViewSet

class DishViewSet(ManyRelatedViewSet):
    queryset = Dish.objects.all()
    serializer_class = DishSerializer
    action_serializer_class = {
        'retrieve': DetailDishSerializer,
        'liked_by_users': UserAbbrSerializer,
        'reviewed_by_users': UserAbbrSerializer,
        'likes': DishLikeSerializer,
        'dish_reviews': DishReviewSerializer,
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
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "liked_by_users" or self.action == "reviewed_by_users":
            context.update({"many": True})
        return context