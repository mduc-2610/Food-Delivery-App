from rest_framework import serializers
from account.models import Setting, SecuritySetting

from utils.serializers import CustomRelatedModelSerializer

class SecuritySettingSerializer(serializers.ModelSerializer):
    class Meta:
        model = SecuritySetting
        fields = ['setting', 'face_id', 'touch_id', 'pin_security']

class SettingSerializer(serializers.ModelSerializer):

    security_setting = SecuritySettingSerializer(read_only=True)
    class Meta:
        model = Setting
        fields = ['id', 'user', 'security_setting', 'notification', 'dark_mode', 'sound', 'automatically_updated', 'language']