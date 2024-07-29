from rest_framework import viewsets, response, status
from rest_framework.decorators import action

from deliverer.models import Deliverer

from account.serializers import UserAbbrSerializer
from deliverer.serializers import DelivererSerializer, DetailDelivererSerializer
from order.serializers import DeliverySerializer
from review.serializers import DelivererReviewSerializer

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet

class DelivererViewSet(ManyRelatedViewSet):
    queryset = Deliverer.objects.all()
    serializer_class = DelivererSerializer
    action_serializer_class = {
        'retrieve': DetailDelivererSerializer,
        'rated_by_users': UserAbbrSerializer,
        'deliveries': DeliverySerializer,
        'user_reviews': DelivererReviewSerializer,
    }
    
    # many_related = {
    #     "rated_by_users": {
    #         'action': (["GET"], "rated-by-users"),
    #         'queryset': lambda instance: instance.rated_by_users.filter(is_registration_verified=True),
    #         'serializer_class': UserAbbrSerializer, 
    #     },
    #     "deliveries": {
    #         'action': (["GET"], "deliveries"),
    #         'queryset': lambda instance: instance.deliveries.all(),
    #         'serializer_class': DeliverySerializer,
    #     },
    #     "user_reviews": {
    #         'action': (["GET"], "user-reviews"),
    #         'queryset': lambda instance: instance.user_reviews.all(),
    #         'serializer_class': DelivererReviewSerializer,
    #     },
    # }

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "list":
            context.update({'detail': False})
        return context
