import random
from django.shortcuts import render
from rest_framework import (
    views, response,
    status, viewsets
)
from rest_framework.decorators import action
from account.throttles import OTPThrottle
from account.models import User, OTP
from account.serializers import (
    UserSerializer, SendOTPSerializer,
    VerifyOTPSerializer, RegisterSerializer
)

from django.utils import timezone

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def get_throttles(self):
        # if self.action == "send_otp":
            # return [OTPThrottle()]
        return []
   
    def get_serializer_class(self):
        if self.action == "send_otp":
            return SendOTPSerializer
        elif self.action == "verify_otp":
            return VerifyOTPSerializer
        elif self.action == "register":
            return RegisterSerializer
        return super().get_serializer_class()

    @action(detail=False, methods=["POST"], url_path="send_otp")
    def send_otp(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        otp = serializer.save()
        
        return response.Response(
            {
                "message": "OTP sent successfully.",
                "code": otp.code,
                "now": timezone.now().astimezone(timezone.get_current_timezone()).strftime("%Y-%m-%d %H:%M:%S %Z"),
                "expired_at": otp.expired_at.astimezone(timezone.get_current_timezone()).strftime("%Y-%m-%d %H:%M:%S %Z")
            },
            status=status.HTTP_200_OK
        )
    
    @action(detail=False, methods=["POST"], url_path="verify_otp")
    def verify_otp(self, request):
        user = request.data.get("user")
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
            return response.Response(
                {
                    "message": "OTP verified successfully."
                },
                status=status.HTTP_200_OK
            )
        return response.Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
    
    @action(detail=False, methods=["POST"], url_path="register")
    def register(self, request):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return response.Response(
                {
                    "message": "User registered successfully."
                },
                status=status.HTTP_201_CREATED
            )
        return response.Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
    