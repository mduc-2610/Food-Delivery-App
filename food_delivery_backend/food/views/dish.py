from rest_framework import (
    response, viewsets, status
)
from rest_framework.decorators import action

from food.models import Dish

from account.serializers import UserAbbrSerializer
from food.serializers import DishSerializer, DetailDishSerializer
from review.serializers import DishReviewSerializer

from utils.views import ManyRelatedViewSet

class DishViewSet(ManyRelatedViewSet):
    queryset = Dish.objects.all()
    serializer_class = DishSerializer
    action_serializer_class = {
        'retrieve': DetailDishSerializer,
        'liked_by_users': UserAbbrSerializer,
        'rated_by_users': UserAbbrSerializer,
    }   
    # many_related = {
    #     'liked_by_users': {
    #         'action': (['GET'], 'liked-by-users'),
    #         'queryset': lambda instance: instance.liked_by_users.all(),
    #         'serializer_class': UserAbbrSerializer,
    #     },
    #     'rated_by_users': {
    #         'action': (['GET'], 'rated-by-users'),
    #         'queryset': lambda instance: instance.rated_by_users.all(),
    #         'serializer_class': UserAbbrSerializer,
    #     }
    # }
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "liked_by_users" or self.action == "rated_by_users":
            context.update({"many": True})
        return context