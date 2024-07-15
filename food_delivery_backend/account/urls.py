from django.contrib import admin
from django.urls import path
from rest_framework import routers

from account.views import UserViewSet

router = routers.DefaultRouter()

router.register('user',  UserViewSet)

urlpatterns = [
]

urlpatterns += router.urls