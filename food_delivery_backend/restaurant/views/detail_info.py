from rest_framework import viewsets

from restaurant.models import DetailInfo

from restaurant.serializers import DetailInfoSerializer

from utils.views import OneToOneViewSet

class DetailInfoViewSet(OneToOneViewSet):
    queryset = DetailInfo.objects.all()
    serializer_class = DetailInfoSerializer
