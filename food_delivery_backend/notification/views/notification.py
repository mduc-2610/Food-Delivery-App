# notifications/views.py
from rest_framework import viewsets

from notification.models import Notification

from notification.serializers import NotificationSerializer

from utils.mixins import DefaultGenericMixin

class NotificationViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer
