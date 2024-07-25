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
from food.serializers import DishSerializer
from notification.serializers import NotificationSerializer
from order.serializers import PromotionSerializer
from deliverer.serializers import DelivererSerializer

from account.throttles import OTPThrottle

from utils.pagination import CustomPagination

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = []
    pagination_class = CustomPagination
    action_serializer_classes = {
        'send_otp': SendOTPSerializer,
        'verify_otp': VerifyOTPSerializer,
        'set_password': SetPasswordSerializer,
        'login_password': LoginPasswordSerializer,
        'rated_dishes': DishSerializer,
        'liked_dishes': DishSerializer,
        'rated_deliverers': DelivererSerializer,
        'promotions': PromotionSerializer,
        'notifications': NotificationSerializer
    }

    def get_serializer_class(self):
        return self.action_serializer_classes.get(self.action, super().get_serializer_class())

    def get_permissions(self):
        # if self.action in ["list", "retrieve"]:
        #     return [IsAuthenticated()]
        return super().get_permissions()
    
    def get_throttles(self):
        # if self.action == "send_otp":
            # return [OTPThrottle()]
        return []
    
    def get_object(self):
        pk = self.kwargs.get('pk', None)
        many_related_queryset = {
            "liked_dishes": lambda instance: instance.liked_dishes.all(),
            "notifications": lambda instance: instance.notifications.all(),
            "promotions": lambda instance: instance.promotions.all(),
            "rated_dishes": lambda instance: instance.rated_dishes.all(),
            "rated_deliverers": lambda instance: instance.rated_deliverers.all()
        }
        if self.action in many_related_queryset.keys():
            try:
                user = User.objects.get(pk=pk)
            except User.DoesNotExist:
                return response.Response(
                    {
                        "message": "User not found."
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
            return many_related_queryset.get(self.action)(user)
        return super().get_object()

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

    def paginate_and_response(self, request):
        queryset = self.get_object()
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        
        serializer = self.get_serializer(queryset, many=True)
        return response.Response(serializer.data, status=status.HTTP_200_OK)

    @action(detail=True, methods=["GET"], url_path="rated-dishes")
    def rated_dishes(self, request, *args, **kwargs):
        return self.paginate_and_response(request)

    @action(detail=True, methods=["GET"], url_path="liked-dishes")
    def liked_dishes(self, request, *args, **kwargs):
        return self.paginate_and_response(request)

    @action(detail=True, methods=["GET"], url_path="rated-deliverers")
    def rated_deliverers(self, request, *args, **kwargs):
        return self.paginate_and_response(request)
    
    @action(detail=True, methods=["GET"], url_path="notifications")
    def notifications(self, request, *args, **kwargs):
        return self.paginate_and_response(request)

    @action(detail=True, methods=["GET"], url_path="promotions")
    def promotions(self, request, *args, **kwargs):
        return self.paginate_and_response(request)

class LocationViewSet(viewsets.ModelViewSet):
    queryset = Location.objects.all()
    serializer_class = LocationSerializer