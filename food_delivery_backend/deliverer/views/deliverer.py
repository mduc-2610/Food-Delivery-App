from rest_framework import viewsets, response, status
from rest_framework.decorators import action

from deliverer.models import Deliverer

from account.serializers import UserAbbrSerializer
from deliverer.serializers import DelivererSerializer, DetailDelivererSerializer
from order.serializers import DeliverySerializer
from review.serializers import DelivererReviewSerializer

from utils.pagination import CustomPagination
from utils.views import BaseModelViewSet

class DelivererViewSet(BaseModelViewSet):
    queryset = Deliverer.objects.all()
    serializer_class = DelivererSerializer
    action_serializer_class = {
        'retrieve': DetailDelivererSerializer,
        'rated_by_users': UserAbbrSerializer,
        'deliveries': DeliverySerializer,
        'user_reviews': DelivererReviewSerializer,
    }
    many_related_queryset = {
        "rated_by_users": lambda instance: instance.rated_by_users.filter(is_registration_verified=True),
        "deliveries": lambda instance: instance.deliveries.all(),
        "user_reviews": lambda instance: instance.user_reviews.all(),
    }

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "list":
            context.update({'many': True})
        return context

    deliveries = BaseModelViewSet.create_action("deliveries")
    rated_by_users = BaseModelViewSet.create_action("rated_by_users")
    user_reviews = BaseModelViewSet.create_action("user_reviews")
    