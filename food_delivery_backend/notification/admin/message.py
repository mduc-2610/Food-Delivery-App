# messaging/admin.py
from django.contrib import admin

class MessageAdmin(admin.ModelAdmin):
    list_display = ['sender', 'receiver', 'message_type', 'timestamp', 'read_status']
    search_fields = ['sender__username', 'receiver__username', 'content']
    list_filter = ['message_type', 'read_status']
    readonly_fields = ['timestamp']

class ImageMessageAdmin(admin.ModelAdmin):
    list_display = ['message', 'image']

class AudioMessageAdmin(admin.ModelAdmin):
    list_display = ['message', 'audio']

class LocationMessageAdmin(admin.ModelAdmin):
    list_display = ['message', 'latitude', 'longitude']
