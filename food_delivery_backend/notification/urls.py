# messaging/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    DirectMessageViewSet, GroupMessageViewSet,
    DirectImageMessageViewSet, GroupImageMessageViewSet,
    DirectVideoMessageViewSet, GroupVideoMessageViewSet,
    DirectRoomViewSet, GroupRoomViewSet,
    NotificationViewSet,
    UserNotificationViewSet
)

router = DefaultRouter()
router.register(r'notification', NotificationViewSet)
router.register(r'direct-message', DirectMessageViewSet)
router.register(r'group-message', GroupMessageViewSet)
router.register(r'direct-image-message', DirectImageMessageViewSet)
router.register(r'group-image-message', GroupImageMessageViewSet)
router.register(r'direct-video-message', DirectVideoMessageViewSet)
router.register(r'group-video-message', GroupVideoMessageViewSet)
router.register(r'direct-room', DirectRoomViewSet)
router.register(r'group-room', GroupRoomViewSet)
router.register(r'user-notification', UserNotificationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
