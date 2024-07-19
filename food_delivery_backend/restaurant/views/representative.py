# representatives/views.py
from rest_framework import viewsets
from restaurant.models import Representative
from restaurant.serializers import RepresentativeSerializer

class RepresentativeViewSet(viewsets.ModelViewSet):
    queryset = Representative.objects.all()
    serializer_class = RepresentativeSerializer
