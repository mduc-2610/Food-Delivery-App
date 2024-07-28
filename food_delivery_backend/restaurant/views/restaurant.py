from restaurant.models import Restaurant
from restaurant.serializers import (
    RestaurantSerializer, DetailRestaurantSerializer
)
from account.serializers import UserAbbrSerializer
from food.serializers import DishSerializer
from order.serializers import PromotionSerializer, RestaurantPromotionSerializer
from review.serializers import RestaurantReviewSerializer

from utils.views import BaseModelViewSet

class RestaurantViewSet(BaseModelViewSet):
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
    many_related_queryset = {
        "promotions": lambda instance: instance.promotions.all(),
        "rated_by_users": lambda instance: instance.rated_by_users.all(),
        "dishes": lambda instance: instance.dishes.all(),
        "user_reviews": lambda instance: instance.user_reviews.all(),
        "owned_promotions": lambda instance: instance.owned_promotions.all(),
    }

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "list":
            context.update({'many': True})
        return context

    promotions = BaseModelViewSet.create_action("promotions")
    rated_by_users = BaseModelViewSet.create_action("rated_by_users")
    dishes = BaseModelViewSet.create_action("dishes")
    user_reviews = BaseModelViewSet.create_action("user_reviews")
    owned_promotions = BaseModelViewSet.create_action("owned_promotions")