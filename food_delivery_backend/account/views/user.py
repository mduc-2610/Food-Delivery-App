import random

from django.db import transaction
from django.utils import timezone
from django.shortcuts import render
from django.contrib.auth import authenticate

from rest_framework import (
    views, response,
    status, viewsets
)
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated

from account.models import (
    User, OTP, Location,
    Profile, Setting, SecuritySetting
)
from account.serializers import (
    UserSerializer, SendOTPSerializer, OTPSerializer, LocationSerializer,
    VerifyOTPSerializer, LoginPasswordSerializer, SetPasswordSerializer
)
from account.throttles import OTPThrottle

from utils.pagination import CustomPagination

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = []
    pagination_class = CustomPagination

    def get_permissions(self):
        # if self.action in ["list", "retrieve"]:
        #     return [IsAuthenticated()]
        return super().get_permissions()
    
    def get_throttles(self):
        # if self.action == "send_otp":
            # return [OTPThrottle()]
        return []
   
    def get_serializer_class(self):
        if self.action == "send_otp":
            return SendOTPSerializer
        elif self.action == "verify_otp":
            return VerifyOTPSerializer
        elif self.action == "set_password":
            return SetPasswordSerializer
        elif self.action == "login_password":
            return LoginPasswordSerializer
        return super().get_serializer_class()

    @action(detail=False, methods=["POST"], url_path="login-password")
    def login_password(self, request):
        phone_number = request.data.get("phone_number")
        password = request.data.get("password")
        user = authenticate(phone_number=phone_number, password=password)
        
        if not user:
            return response.Response(
                {
                    "message": "Invalid phone number or password."
                },
                status=status.HTTP_400_BAD_REQUEST
            )

        refresh = RefreshToken.for_user(user)
        return response.Response(
            {
                "refresh": str(refresh),
                "access": str(refresh.access_token),
            },
            status=status.HTTP_200_OK
        )

    @action(detail=False, methods=["POST"], url_path="send-otp")
    def send_otp(self, request):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            instance = serializer.save()
            return response.Response(
                {
                    "message": "OTP sent successfully.",
                    "data": instance
                },
                status=status.HTTP_200_OK
            )
        return response.Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
        
    @action(detail=False, methods=["POST"], url_path="verify-otp")
    def verify_otp(self, request):
        user = request.data.get("user")
        user = User.objects.get(id=user)
        otp_exists = OTP.objects.filter(user=user).exists()

        """
        Check if user has been created or not
        """
        if not otp_exists:
            return response.Response(
                {
                    "message": "You must request an OTP first."
                },
                status=status.HTTP_400_BAD_REQUEST
            )
            
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            if user.password:
                refresh = RefreshToken.for_user(user)
                return response.Response(
                    {
                        "refresh": str(refresh),
                        "access": str(refresh.access_token),
                    },
                    status=status.HTTP_201_CREATED
                )
            else:
                return response.Response(
                    {
                        "message": "Verification successful! Please set your password."
                    },
                    status=status.HTTP_200_OK
                )
        return response.Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
    
    @action(detail=False, methods=["POST"], url_path="set-password")
    def set_password(self, request):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            with transaction.atomic():
                profile, created_profile = Profile.objects.get_or_create(user=user)
                
                if created_profile or not hasattr(user, 'setting'):
                    setting, created_setting = Setting.objects.get_or_create(user=user)
                    if created_setting:
                        SecuritySetting.objects.get_or_create(setting=setting)
                
            refresh = RefreshToken.for_user(user)
            return response.Response(
                {
                    "refresh": str(refresh),
                    "access": str(refresh.access_token),
                },
                status=status.HTTP_201_CREATED
            )
        return response.Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )

class LocationViewSet(viewsets.ModelViewSet):
    queryset = Location.objects.all()
    serializer_class = LocationSerializer