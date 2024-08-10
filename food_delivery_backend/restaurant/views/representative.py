from rest_framework import viewsets

from restaurant.models import Representative

from restaurant.serializers import RepresentativeSerializer

from utils.views import OneRelatedViewSet

from utils.mixins import DefaultGenericMixin

class RepresentativeViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = Representative.objects.all()
    serializer_class = RepresentativeSerializer