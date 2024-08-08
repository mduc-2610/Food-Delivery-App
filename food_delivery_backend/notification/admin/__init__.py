from django.contrib import admin

from .message import DirectMessageAdmin, GroupMessageAdmin
from .room import DirectRoomAdmin, GroupRoomAdmin
from .notification import NotificationAdmin
from .user_notification import UserNotificationAdmin

from notification.models import (
    DirectMessage, GroupMessage,
    DirectRoom, GroupRoom,
    Notification,
    UserNotification
)

admin.site.register(DirectMessage, DirectMessageAdmin)
admin.site.register(GroupMessage, GroupMessageAdmin)
admin.site.register(DirectRoom, DirectRoomAdmin)
admin.site.register(GroupRoom, GroupRoomAdmin)
admin.site.register(Notification, NotificationAdmin)
admin.site.register(UserNotification, UserNotificationAdmin)
