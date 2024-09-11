import re
from rest_framework import viewsets, response, status
from rest_framework.decorators import action

from deliverer.models import Deliverer

from account.serializers import BasicUserSerializer
from deliverer.serializers import DelivererSerializer, DetailDelivererSerializer
from order.serializers import (
    DeliverySerializer, 
    # DeliveryRequestSerializer,
)
from review.serializers import DelivererReviewSerializer

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin

class DelivererViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = Deliverer.objects.all()
    serializer_class = DelivererSerializer
    many_related_serializer_class = {
        'retrieve': DetailDelivererSerializer,
        'reviewed_by_users': BasicUserSerializer,
        'deliveries': DeliverySerializer,
        'deliverer_reviews': DelivererReviewSerializer,
        'delivery_requests': DeliverySerializer,
        # 'delivery_requests': DeliverySerializer,
        # 'requests': DeliveryRequestSerializer,
    }

    # many_related = {
    #     'delivery_requests': {
    #         'pagination': False
    #     }
    # }
    def get_object(self):
        object = super().get_object()
        params = self.request.query_params
        if self.action == "requests" or self.action == "delivery_requests":
            status = params.get('status')
            filter_kwargs = {}
            if status:
                split_status = re.sub(r'\W+', '_', status).upper()
                filter_kwargs[f"{'status' if self.action == 'delivery_requests' else 'delivery__status'}"] = split_status
            elif self.action == "requests":
                return object.exclude(status="FINDING_DRIVER").order_by("-created_at")
            elif self.action == "delivery_requests":
                return object.exclude(status="FINDING_DRIVER")
            return object.filter(**filter_kwargs).order_by("-created_at")
        return object
    
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
