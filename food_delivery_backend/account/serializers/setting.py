from rest_framework import serializers
from account.models import Setting, SecuritySetting

class SettingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Setting
        fields = ['user', 'notification', 'dark_mode', 'sound', 'automatically_updated', 'language']

class SecuritySettingSerializer(serializers.ModelSerializer):
    class Meta:
        model = SecuritySetting
        fields = ['setting', 'face_id', 'touch_id', 'pin_security']
