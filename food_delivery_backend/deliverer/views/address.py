from rest_framework import viewsets

from deliverer.models import Address

from deliverer.serializers import AddressSerializer

from utils.views import OneToOneViewSet

class AddressViewSet(OneToOneViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer
