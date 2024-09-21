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

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin

class DelivererViewSet(DefaultGenericMixin, ReviewFilterMixin, ManyRelatedViewSet):
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
    def get_object(self):
        queryset = super().get_object()
        params = self.request.query_params

        if self.action in ["requests", "delivery_requests"]:
            sep = params.get('sep', ',')
            
            try:
                status_list = [
                    re.sub(r'\W+', '_', x.strip()).upper()
                    for x in params.get('status', '').split(sep) if x
                ]
            except Exception:
                status_list = []
                print("Error parsing status", pretty=True)

            try:
                exclude_status_list = [
                    re.sub(r'\W+', '_', x.strip()).upper()
                    for x in params.get('exclude_status', '').split(sep) if x
                ]
            except Exception:
                exclude_status_list = []
                print("Error parsing exclude status", pretty=True)

            filter_kwargs = {}
            exclude_kwargs = {}

            if status_list:
                filter_kwargs[f"{'status__in' if self.action == 'delivery_requests' else 'delivery__status__in'}"] = status_list

            if exclude_status_list:
                exclude_kwargs[f"{'status__in' if self.action == 'delivery_requests' else 'delivery__status__in'}"] = exclude_status_list

            if not status_list and not exclude_status_list:
                exclude_kwargs[f"{'status__in' if self.action == 'delivery_requests' else 'delivery__status__in'}"] = ["FINDING_DRIVER", "ON_THE_WAY"]

            date = params.get('date')
            if date:
                try:
                    filter_date = datetime.strptime(date, '%Y-%m-%d').date()
                    start_of_day = datetime.combine(filter_date, datetime.min.time())
                    end_of_day = datetime.combine(filter_date, datetime.max.time())
                    
                    if self.action == 'requests':
                        queryset = queryset.filter(
                            Q(created_at__range=(start_of_day, end_of_day)) |
                            Q(delivery__started_at__range=(start_of_day, end_of_day)) |
                            Q(delivery__finished_at__range=(start_of_day, end_of_day))
                        )
                    else:
                        queryset = queryset.filter(
                            Q(created_at__range=(start_of_day, end_of_day))
                        )
                except ValueError as e:
                    print(f"Error parsing date: {e}")

            if filter_kwargs:
                queryset = queryset.filter(**filter_kwargs)

            if exclude_kwargs:
                queryset = queryset.exclude(**exclude_kwargs)

            return queryset.order_by("-created_at")

        elif self.action == "deliveries":
            date = params.get('date')
            if date:
                try:
                    filter_date = datetime.strptime(date, '%Y-%m-%d').date()
                    return queryset.filter(
                        Q(created_at__date=filter_date) |
                        Q(started_at__date=filter_date) |
                        Q(finished_at__date=filter_date)
                    ).order_by("-created_at")
                except ValueError:
                    return queryset

        return queryset

    
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
