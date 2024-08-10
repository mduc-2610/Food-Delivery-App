from rest_framework import viewsets
from rest_framework.exceptions import NotFound

from account.models import Setting, SecuritySetting

from account.serializers import SettingSerializer, SecuritySettingSerializer

from utils.views import OneRelatedViewSet
from utils.mixins import DefaultGenericMixin

class SettingViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = Setting.objects.all()
    serializer_class = SettingSerializer
        
class SecuritySettingViewSet(DefaultGenericMixin, OneRelatedViewSet):
    queryset = SecuritySetting.objects.all()
    serializer_class = SecuritySettingSerializer
