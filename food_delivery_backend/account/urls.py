from django.contrib import admin
from django.urls import path
from rest_framework import routers
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from account.views import (
    UserViewSet, 
    ProfileViewSet, LocationViewSet,
    SettingViewSet, SecuritySettingViewSet,
)
router = routers.DefaultRouter()

router.register(r'user',  UserViewSet)
router.register(r'profile', ProfileViewSet)
router.register(r'location', LocationViewSet)
router.register(r'setting', SettingViewSet)
router.register(r'security-setting', SecuritySettingViewSet)

urlpatterns = [
    path('refresh-token/', TokenRefreshView.as_view(), name='refresh_token'),
]

urlpatterns += router.urls