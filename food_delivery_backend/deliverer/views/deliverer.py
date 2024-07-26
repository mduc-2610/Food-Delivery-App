from rest_framework import viewsets

from deliverer.models import Deliverer

from deliverer.serializers import DelivererSerializer

class DelivererViewSet(viewsets.ModelViewSet):
    queryset = Deliverer.objects.all()
    serializer_class = DelivererSerializer
