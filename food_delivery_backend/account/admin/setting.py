from django.contrib import admin
from account.models import Setting, SecuritySetting

class SettingAdmin(admin.ModelAdmin):
    list_display = ['user', 'notification', 'dark_mode', 'sound', 'automatically_updated', 'language']
    search_fields = ['user__username', 'language']

class SecuritySettingAdmin(admin.ModelAdmin):
    list_display = ['setting', 'face_id', 'touch_id', 'pin_security']
    search_fields = ['setting__user__username']
