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
router.register(r'message', MessageViewSet)
router.register(r'image-message', ImageMessageViewSet)
router.register(r'audio-message', AudioMessageViewSet)
router.register(r'location-message', LocationMessageViewSet)
router.register(r'notification', NotificationViewSet)
router.register(r'user-notification', UserNotificationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
