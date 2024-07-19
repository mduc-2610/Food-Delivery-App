# addresses/views.py
from rest_framework import viewsets
from deliverer.models import Address
from deliverer.serializers import AddressSerializer

class AddressViewSet(viewsets.ModelViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer
