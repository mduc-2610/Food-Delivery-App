# notifications/admin.py
from django.contrib import admin

class NotificationAdmin(admin.ModelAdmin):
    list_display = ['notification_type', 'title', 'description']
    search_fields = ['title', 'description']
    list_filter = ['notification_type']
