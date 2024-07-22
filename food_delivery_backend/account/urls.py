from django.contrib import admin
from django.urls import path
from rest_framework import routers

from account.views import (
    UserViewSet, 
    ProfileViewSet, LocationViewSet,
    SettingViewSet, SecuritySettingViewSet,
)
router = routers.DefaultRouter()

router.register(r'user',  UserViewSet)
router.register(r'profiles', ProfileViewSet)
router.register(r'locations', LocationViewSet)
router.register(r'settings', SettingViewSet)
router.register(r'security-settings', SecuritySettingViewSet)

urlpatterns = [
]

urlpatterns += router.urls