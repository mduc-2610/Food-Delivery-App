# detailinfo/views.py
from rest_framework import viewsets
from restaurant.models import DetailInfo
from restaurant.serializers import DetailInfoSerializer

class DetailInfoViewSet(viewsets.ModelViewSet):
    queryset = DetailInfo.objects.all()
    serializer_class = DetailInfoSerializer
