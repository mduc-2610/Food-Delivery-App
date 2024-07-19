from django.contrib import admin

from .message import MessageAdmin, AudioMessageAdmin, ImageMessageAdmin, LocationMessageAdmin
from .notification import NotificationAdmin
from .user_notification import UserNotificationAdmin

from notification.models import (
    Message, AudioMessage, ImageMessage, LocationMessage,
    Notification,
    UserNotification
)

admin.site.register(Message, MessageAdmin)
admin.site.register(AudioMessage, AudioMessageAdmin)
admin.site.register(ImageMessage, ImageMessageAdmin)
admin.site.register(LocationMessage, LocationMessageAdmin)
admin.site.register(Notification, NotificationAdmin)
admin.site.register(UserNotification, UserNotificationAdmin)
