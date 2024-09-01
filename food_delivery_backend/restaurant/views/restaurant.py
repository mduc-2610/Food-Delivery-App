from rest_framework import viewsets

from restaurant.models import Restaurant, RestaurantCategory
from restaurant.serializers import (
    RestaurantSerializer, DetailRestaurantSerializer, RestaurantCategorySerializer
)
from account.serializers import BasicUserSerializer
from food.serializers import DishSerializer, DishCategorySerializer
from order.serializers import PromotionSerializer, RestaurantPromotionSerializer
from review.serializers import RestaurantReviewSerializer

from review.mixins import ReviewFilterMixin

from utils.views import ManyRelatedViewSet
from utils.pagination import CustomPagination
from utils.mixins import DefaultGenericMixin

class RestaurantViewSet(DefaultGenericMixin, ReviewFilterMixin, ManyRelatedViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'retrieve': DetailRestaurantSerializer,
        'promotions': PromotionSerializer,
        'reviewed_by_users': BasicUserSerializer,
        'dishes': DishSerializer,
        'restaurant_reviews': RestaurantReviewSerializer,
        'owned_promotions': RestaurantPromotionSerializer,
        'categories': DishCategorySerializer,
    }
    many_related = {
        'dishes': {
            'pagination': False,
        }
    }
    # many_related = {
    #     "promotions": {
    #         'action': (["GET"], "promotions"),
    #         'queryset': lambda instance: instance.promotions.all(),
    #         'serializer_class': PromotionSerializer,
    #     },
    #     "reviewed_by_users": {
    #         'action': (["GET"], "reviewed-by-users"),
    #         'queryset': lambda instance: instance.reviewed_by_users.all(),
    #         'serializer_class': UserAbbrSerializer,
    #     },
    #     "dishes": {
    #         'action': (["GET"], "dishes"),
    #         'queryset': lambda instance: instance.dishes.all(),
    #         'serializer_class': DishSerializer,
    #     },
    #     "user_reviews": {
    #         'action': (["GET"], "user-reviews"),
    #         'queryset': lambda instance: instance.user_reviews.all(),
    #         'serializer_class': RestaurantReviewSerializer,
    #     },
    #     "owned_promotions": {
    #         'action': (["GET"], "owned-promotions"),
    #         'queryset': lambda instance: instance.owned_promotions.all(),
    #         'serializer_class': RestaurantPromotionSerializer,
    #     },
    # }
    def get_queryset(self):
        queryset = super().get_queryset()
        name = self.request.query_params.get('name')
        if name:
            queryset = queryset.filter(basic_info__name__icontains=name)
        return queryset
    
    def get_object(self):
        if self.action == 'restaurant_reviews':
            return ReviewFilterMixin.get_object(self)
        return super().get_object()

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "list":
            context.update({'detail': False})
        return context
    
    

class RestaurantCategoryViewSet(viewsets.ModelViewSet):
    queryset = RestaurantCategory.objects.all()
    serializer_class = RestaurantCategorySerializer
