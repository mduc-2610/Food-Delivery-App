# detailinformation/views.py
from rest_framework import viewsets
from restaurant.models import DetailInformation
from restaurant.serializers import DetailInformationSerializer

class DetailInformationViewSet(viewsets.ModelViewSet):
    queryset = DetailInformation.objects.all()
    serializer_class = DetailInformationSerializer
