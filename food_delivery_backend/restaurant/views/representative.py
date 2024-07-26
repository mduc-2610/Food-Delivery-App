from rest_framework import viewsets

from restaurant.models import Representative

from restaurant.serializers import RepresentativeSerializer

from utils.views import OneToOneViewSet

class RepresentativeViewSet(OneToOneViewSet):
    queryset = Representative.objects.all()
    serializer_class = RepresentativeSerializer
