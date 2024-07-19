from rest_framework import viewsets
from account.models import Setting, SecuritySetting
from account.serializers import SettingSerializer, SecuritySettingSerializer

class SettingViewSet(viewsets.ModelViewSet):
    queryset = Setting.objects.all()
    serializer_class = SettingSerializer

class SecuritySettingViewSet(viewsets.ModelViewSet):
    queryset = SecuritySetting.objects.all()
    serializer_class = SecuritySettingSerializer
