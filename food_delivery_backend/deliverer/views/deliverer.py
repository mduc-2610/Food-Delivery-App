import re
from datetime import datetime

from django.db.models import Q

from rest_framework import viewsets, response, status
from rest_framework.decorators import action

from deliverer.models import Deliverer

from account.serializers import BasicUserSerializer
from deliverer.serializers import (
    DelivererSerializer,
    DetailDelivererSerializer,
    CreateDelivererSerializer,
)
from order.serializers import (
    DeliverySerializer, 
    DeliveryRequestSerializer,
)
from review.serializers import DelivererReviewSerializer

from review.mixins import ReviewFilterMixin
from order.mixins import DeliveryFilterMixin

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin

class DelivererViewSet(DefaultGenericMixin,  DeliveryFilterMixin, ReviewFilterMixin, ManyRelatedViewSet):
    queryset = Deliverer.objects.all()
    serializer_class = DelivererSerializer
    many_related_serializer_class = {
        'retrieve': DetailDelivererSerializer,
        'create': CreateDelivererSerializer,
        'reviewed_by_users': BasicUserSerializer,
        'deliveries': DeliverySerializer,
        'deliverer_reviews': DelivererReviewSerializer,
        'delivery_requests': DeliverySerializer,
        # 'requests': DeliveryRequestSerializer,
    }

    # many_related = {
    #     'delivery_requests': {
    #         'pagination': False
    #     }
    # }
    

    
    # many_related = {
    #     "reviewed_by_users": {
    #         'action': (["GET"], "reviewed-by-users"),
    #         'queryset': lambda instance: instance.reviewed_by_users.filter(is_registration_verified=True),
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
