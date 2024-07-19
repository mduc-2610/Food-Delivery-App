# notifications/views.py
from rest_framework import viewsets
from notification.models import Notification
from notification.serializers import NotificationSerializer

class NotificationViewSet(viewsets.ModelViewSet):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer
