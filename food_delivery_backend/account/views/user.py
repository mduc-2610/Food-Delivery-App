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
from food.serializers import DishSerializer, DishLikeSerializer
from notification.serializers import NotificationSerializer
from order.serializers import PromotionSerializer, DeliverySerializer
from deliverer.serializers import DelivererSerializer
from restaurant.serializers import RestaurantSerializer
from review.serializers import (
    DeliveryReviewSerializer, DelivererReviewSerializer,
    DishReviewSerializer, RestaurantReviewSerializer
)
from social.serializers import (
    PostSerializer, CommentSerializer,
    CommentLikeSerializer,
    DetailPostSerializer
)
from notification.serializers import DirectRoomSerializer
from account.throttles import OTPThrottle

from utils.pagination import CustomPagination
from utils.views import ManyRelatedViewSet
from utils.mixins import DefaultGenericMixin

class UserViewSet(DefaultGenericMixin, ManyRelatedViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = []
    pagination_class = CustomPagination
    mapping_serializer_class = {
        'send_otp': SendOTPSerializer,
        'verify_otp': VerifyOTPSerializer,
        'set_password': SetPasswordSerializer,
        'login_password': LoginPasswordSerializer,
    }
    many_related_serializer_class = {
        'promotions': PromotionSerializer,
        'notifications': NotificationSerializer,
        'comments': PostSerializer,
        'posts': PostSerializer,

        'liked_posts': DetailPostSerializer,
        'liked_comments': CommentSerializer,
        'liked_dishes': DishSerializer,
        'liked_delivery_reviews': DeliveryReviewSerializer,
        'liked_deliverer_reviews': DelivererReviewSerializer,
        'liked_restaurant_reviews': RestaurantReviewSerializer,
        'liked_dish_reviews': DishReviewSerializer,
        
        'reviewed_dishes': DishSerializer,
        'reviewed_deliverers': DelivererSerializer,
        'reviewed_deliveries': DeliverySerializer,
        'reviewed_restaurants': RestaurantSerializer,
        
        'dish_likes': DishLikeSerializer,
        'post_comments': CommentSerializer,
        'comment_likes': CommentLikeSerializer,

        'user1_rooms': DirectRoomSerializer,
        'user2_rooms': DirectRoomSerializer,
    }
    # many_related = {
    #     'reviewed_dishes': {
    #         'action': (['GET'], 'reviewed-dishes'),
    #         'queryset': lambda instance: instance.reviewed_dishes.all(),
    #         'serializer_class': DishSerializer,
    #     },
    #     'liked_dishes': {
    #         'action': (['GET'], 'liked-dishes'),
    #         'queryset': lambda instance: instance.liked_dishes.all(),
    #         'serializer_class': DishSerializer,
    #     },
    #     'reviewed_deliverers': {
    #         'action': (['GET'], 'reviewed-deliverers'),
    #         'queryset': lambda instance: instance.reviewed_deliverers.all(),
    #         'serializer_class': DelivererSerializer,
    #     },
    #     'reviewed_deliveries': {
    #         'action': (['GET'], 'reviewed-deliveries'),
    #         'queryset': lambda instance: instance.reviewed_deliveries.all(),
    #         'serializer_class': DeliverySerializer,
    #     },
    #     'notifications': {
    #         'action': (['GET'], 'notifications'),
    #         'queryset': lambda instance: instance.notifications.all(),
    #         'serializer_class': PromotionSerializer,
    #     },
    #     'promotions': {
    #         'action': (['GET'], 'promotions'),
    #         'queryset': lambda instance: instance.promotions.all(),
    #         'serializer_class': NotificationSerializer,
    #     }
    # }

    def get_serializer_class(self):
        return self.many_related_serializer_class.get(self.action, super().get_serializer_class())

    def get_permissions(self):
        # if self.action in ['list', 'retrieve', 'get_user_details']:
        #     return [IsAuthenticated()]
        return super().get_permissions()
    
    def get_throttles(self):
        # if self.action == 'send_otp':
            # return [OTPThrottle()]
        return []

    def get_queryset(self):
        if self.action == 'list':
            return User.objects.filter(is_registration_verified=True)            
        return super().get_queryset()
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == 'list':
            context.update({'detail': False})
        return context

    @action(detail=False, methods=['POST'], url_path='login-password')
    def login_password(self, request):
        phone_number = request.data.get('phone_number')
        password = request.data.get('password')
        user = authenticate(phone_number=phone_number, password=password)
        
        if not user:
            return response.Response(
                {
                    'message': 'Invalid phone number or password.'
                },
                status=status.HTTP_400_BAD_REQUEST
            )

        refresh = RefreshToken.for_user(user)
        return response.Response(
            {
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            },
            status=status.HTTP_200_OK
        )

    @action(detail=False, methods=['POST'], url_path='send-otp')
    def send_otp(self, request):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            instance = serializer.save()            
            return response.Response(
                {
                    'message': 'OTP sent successfully.',
                    'data': instance
                },
                status=status.HTTP_200_OK
            )
        return response.Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
        
    @action(detail=False, methods=['POST'], url_path='verify-otp')
    def verify_otp(self, request):
        user = request.data.get('user')
        user = User.objects.get(id=user)
        otp_exists = OTP.objects.filter(user=user).exists()

        '''
        Check if user has been created or not
        '''
        if not otp_exists:
            return response.Response(
                {
                    'message': 'You must request an OTP first.'
                },
                status=status.HTTP_400_BAD_REQUEST
            )
            
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            if user.password:
                refresh = RefreshToken.for_user(user)
                return response.Response(
                    {
                        'refresh': str(refresh),
                        'access': str(refresh.access_token),
                    },
                    status=status.HTTP_201_CREATED
                )
            else:
                return response.Response(
                    {
                        'message': 'Verification successful! Please set your password.'
                    },
                    status=status.HTTP_200_OK
                )
        return response.Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
    
    @action(detail=False, methods=['POST'], url_path='set-password')
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
                    'refresh': str(refresh),
                    'access': str(refresh.access_token),
                },
                status=status.HTTP_201_CREATED
            )
        return response.Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
    
    @action(detail=False, methods=['GET'], url_path='me')
    def get_user_details(self, request):
        serializer = self.get_serializer(request.user)
        return response.Response(serializer.data, status=status.HTTP_200_OK)

class LocationViewSet(viewsets.ModelViewSet):
    queryset = Location.objects.all()
    serializer_class = LocationSerializer