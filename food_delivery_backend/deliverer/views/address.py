from rest_framework import viewsets

from deliverer.models import Address

from deliverer.serializers import AddressSerializer

from utils.views import OneRelatedViewSet

class AddressViewSet(OneRelatedViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer
