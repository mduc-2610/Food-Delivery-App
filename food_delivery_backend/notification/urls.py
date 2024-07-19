# messaging/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    MessageViewSet,
    ImageMessageViewSet,
    AudioMessageViewSet,
    LocationMessageViewSet,
    NotificationViewSet,
    UserNotificationViewSet
)

router = DefaultRouter()
router.register(r'messages', MessageViewSet)
router.register(r'image-messages', ImageMessageViewSet)
router.register(r'audio-messages', AudioMessageViewSet)
router.register(r'location-messages', LocationMessageViewSet)
router.register(r'notifications', NotificationViewSet)
router.register(r'user-notifications', UserNotificationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
