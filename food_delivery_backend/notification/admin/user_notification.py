# notifications/admin.py
from django.contrib import admin

class UserNotificationAdmin(admin.ModelAdmin):
    list_display = ['user', 'notification', 'timestamp', 'read_status']
    search_fields = ['user__username', 'notification__title']
    list_filter = ['read_status', 'timestamp']
    readonly_fields = ['timestamp']
