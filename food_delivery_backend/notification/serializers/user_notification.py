# notifications/serializers.py
from rest_framework import serializers
from notification.models import UserNotification

class UserNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserNotification
        fields = ['id', 'user', 'notification', 'timestamp', 'read_status']
        read_only_fields = ['timestamp']
