from rest_framework import viewsets

from restaurant.models import Representative

from restaurant.serializers import RepresentativeSerializer

from utils.views import OneRelatedViewSet

class RepresentativeViewSet(OneRelatedViewSet):
    queryset = Representative.objects.all()
    serializer_class = RepresentativeSerializer
