from django.contrib import admin
from django.urls import path
from rest_framework import routers

from account.views import (
    UserViewSet, 
    ProfileViewSet, 
    SettingViewSet, SecuritySettingViewSet,
)
router = routers.DefaultRouter()

router.register(r'user',  UserViewSet)
router.register(r'profile', ProfileViewSet)
router.register(r'settings', SettingViewSet)
router.register(r'security-settings', SecuritySettingViewSet)

urlpatterns = [
]

urlpatterns += router.urls