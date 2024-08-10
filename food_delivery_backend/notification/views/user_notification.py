# notifications/views.py
from rest_framework import viewsets

from notification.models import UserNotification

from notification.serializers import UserNotificationSerializer

from utils.mixins import DefaultGenericMixin

class UserNotificationViewSet(DefaultGenericMixin,viewsets.ModelViewSet):
    queryset = UserNotification.objects.all()
    serializer_class = UserNotificationSerializer
