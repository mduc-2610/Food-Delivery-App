# notifications/serializers.py
from rest_framework import serializers
from notification.models import Notification

class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = ['id', 'notification_type', 'title', 'description']
