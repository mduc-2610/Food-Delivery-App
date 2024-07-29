from restaurant.models import Restaurant
from restaurant.serializers import (
    RestaurantSerializer, DetailRestaurantSerializer
)
from account.serializers import UserAbbrSerializer
from food.serializers import DishSerializer
from order.serializers import PromotionSerializer, RestaurantPromotionSerializer
from review.serializers import RestaurantReviewSerializer

from utils.views import ManyRelatedViewSet

class RestaurantViewSet(ManyRelatedViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer
    action_serializer_class = {
        'retrieve': DetailRestaurantSerializer,
        'promotions': PromotionSerializer,
        'rated_by_users': UserAbbrSerializer,
        'dishes': DishSerializer,
        'user_reviews': RestaurantReviewSerializer,
        'owned_promotions': RestaurantPromotionSerializer
    }
    # many_related = {
    #     "promotions": {
    #         'action': (["GET"], "promotions"),
    #         'queryset': lambda instance: instance.promotions.all(),
    #         'serializer_class': PromotionSerializer,
    #     },
    #     "rated_by_users": {
    #         'action': (["GET"], "rated-by-users"),
    #         'queryset': lambda instance: instance.rated_by_users.all(),
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

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "list":
            context.update({'detail': False})
        return context