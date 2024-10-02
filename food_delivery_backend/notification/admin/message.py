from django.contrib import admin
from notification.models import DirectMessage, GroupMessage, DirectImageMessage, DirectVideoMessage, GroupImageMessage, GroupVideoMessage

class DirectImageMessageInline(admin.StackedInline):
    model = DirectImageMessage
    extra = 0

class DirectVideoMessageInline(admin.StackedInline):
    model = DirectVideoMessage
    extra = 0

class GroupImageMessageInline(admin.StackedInline):
    model = GroupImageMessage
    extra = 0

class GroupVideoMessageInline(admin.StackedInline):
    model = GroupVideoMessage
    extra = 0

class DirectMessageAdmin(admin.ModelAdmin):
    list_display = ('user', 'room', 'created_at')
    search_fields = ('user__phone_number', 'content')
    list_filter = ('created_at',)
    inlines = [DirectImageMessageInline, DirectVideoMessageInline]

class GroupMessageAdmin(admin.ModelAdmin):
    list_display = ('user', 'room', 'created_at')
    search_fields = ('user__phone_number', 'content')
    list_filter = ('created_at',)
    inlines = [GroupImageMessageInline, GroupVideoMessageInline]

