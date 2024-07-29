from rest_framework import viewsets
from rest_framework.exceptions import NotFound

from account.models import Setting, SecuritySetting

from account.serializers import SettingSerializer, SecuritySettingSerializer

from utils.views import OneRelatedViewSet

class SettingViewSet(OneRelatedViewSet):
    queryset = Setting.objects.all()
    serializer_class = SettingSerializer
        
class SecuritySettingViewSet(viewsets.ModelViewSet):
    queryset = SecuritySetting.objects.all()
    serializer_class = SecuritySettingSerializer
