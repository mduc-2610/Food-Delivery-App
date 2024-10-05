import random
from django.core.validators import RegexValidator
from django.utils import timezone
from django.db.models import Q

from rest_framework import serializers
from rest_framework.reverse import reverse

from account.models import (
    User, OTP, UserLocation,
    Profile, Setting
)

from account.serializers.profile import ProfileSerializer
from account.serializers.setting import SettingSerializer

from utils.regex_validators import phone_regex, password_regex
from utils.function import get_related_url 
from utils.serializers import CustomRelatedModelSerializer

class UserLocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserLocation

        fields = ['id', 'address', 'latitude', 'longitude', 'name', 'user', 'is_selected']

class UserSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.one_related_serializer_class = {
            'profile': ProfileSerializer,
            'setting': SettingSerializer,
            'deliverer': 'primary_related_field',
            'restaurant': 'primary_related_field',
        }
    
    restaurant_cart = serializers.SerializerMethodField()
    def get_restaurant_cart(self, obj):
        from order.models import RestaurantCart
        from order.serializers import BasicRestaurantCartSerializer

        if hasattr(self, 'request'):
            restaurant_id = self.request.query_params.get('restaurant')
            if restaurant_id:
                filter_kwargs = {
                    'user': obj,
                    'restaurant': restaurant_id,
                    'order__delivery': None,
                }
                try:
                    res_cart = RestaurantCart.objects.filter(**filter_kwargs).first()
                    if res_cart:
                        return BasicRestaurantCartSerializer(res_cart, context=self.context).data
                    else:
                        return None
                except:
                    return None
        return None

    selected_location = serializers.SerializerMethodField()
    
    def get_selected_location(self, obj):
        if hasattr(obj, 'locations') :
            selected_location = obj.locations.filter(is_selected=True).first()
            if selected_location:
                return UserLocationSerializer(selected_location).data
            return None
        return None
    
    class Meta:
        model = User
        fields = [
            'id', 
            'is_certified_deliverer',   
            'is_certified_restaurant',
            'deliverer', 
            'restaurant', 
            'selected_location', 
            'phone_number', 
            'email', 
            'is_registration_verified', 
            'is_active', 
            'is_staff', 
            'is_superuser', 
            'date_joined', 
            'last_login', 
            'restaurant_cart',
        ]

class OTPSerializer(serializers.ModelSerializer):
    class Meta:
        model = OTP
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }

class SendOTPSerializer(serializers.Serializer):
    phone_number = serializers.CharField(validators=[phone_regex], max_length=16, write_only=True)
    is_forgot_password = serializers.BooleanField(write_only=True)

    def validate(self, data):
        phone_number = data.get("phone_number")
        is_forgot_password = data.get("is_forgot_password", False)
        user = User.objects.filter(phone_number=phone_number).first()
        otp = OTP.objects.filter(user__phone_number=phone_number).first()

        if is_forgot_password and not user:
            raise serializers.ValidationError("This phone number has not been registered yet.")
        if otp and not otp.has_expired():
            raise serializers.ValidationError("OTP is still valid.")
        
        return data

    def create(self, validated_data):
        phone_number = validated_data.get("phone_number")
        user, created = User.objects.get_or_create(phone_number=phone_number)
        code = str(random.randint(1000, 9999))
        otp, created_otp = OTP.objects.get_or_create(user=user, defaults={'code': code})
        """
        Key Differences
        Field Specification for Creation:
        With defaults: You can specify fields that should be set when creating a new record but not required for looking up the record. This is useful when you only want to look up based on some fields but set additional fields on creation.
        Without defaults: Both fields are used for looking up the existing record and for setting the fields of the new record if none is found.
        
        Field Constraints:
        With defaults: Only the fields passed as part of the lookup parameters (user in this case) are used to search for existing records. The defaults parameter is used only if a new record is created.
        Without defaults: Both lookup fields (user and code) are used to find an existing record. The combination must be unique or suitable for the application’s needs.
        
        Example Scenario
        With defaults: You want to ensure that if a record for a user exists, you only update the code if the record doesn’t already have it. For instance, you may want to update the OTP code every time a new OTP is generated.
        Without defaults: You want to ensure that the combination of user and code is unique. This approach would be used if you want to enforce a unique constraint on the combination of user and code.
        """
        
        if not created_otp:
            otp.code = code
            otp.save()
        
        return {
            'otp': OTPSerializer(otp).data,
            'user': UserSerializer(user, context=self.context).data
        }


class VerifyOTPSerializer(serializers.Serializer):
    code = serializers.CharField(max_length=4)
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    is_login = serializers.BooleanField()

    def validate(self, data):
        code = data.get("code")
        user = data.get("user")
        is_login = data.get("is_login")

        otp = OTP.objects.filter(user=user, code=code).first()
        if not otp:
            raise serializers.ValidationError("Invalid OTP.")
        if timezone.now() >= otp.expired_at:
            raise serializers.ValidationError("OTP has expired.")

        if not is_login:
            self._validate_registration(user)
        # else:
        #     self._validate_login(user)
        user.save()

        return data

    def _validate_registration(self, user):
        """Validate the user's registration status."""
        if user.is_registration_verified and user.password:
            raise serializers.ValidationError("User's phone number has already been registered.")
        
    # def _validate_login(self, user):
    #     """Validate the user's login status."""
    #     if not user.is_registration_verified and not user.password:
    #         raise serializers.ValidationError("User's phone number has not been registered yet.")
        

class LoginPasswordSerializer(serializers.Serializer):
    phone_number = serializers.CharField(validators=[phone_regex], max_length=16)
    password = serializers.CharField(write_only=True)

class SetPasswordSerializer(serializers.ModelSerializer):
    password1 = serializers.CharField(
        write_only=True,
        validators=[password_regex]
    )
    password2 = serializers.CharField(
        write_only=True
    )
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())

    class Meta:
        model = User 
        fields = (
            "phone_number",
            "password1",
            "password2",
            "user"
        )
        extra_kwargs = {
            "phone_number": {"read_only": True},
        }
        

    def validate(self, data):
        if data["password1"] != data["password2"]:
            raise serializers.ValidationError("Passwords do not match.")
        return data
    
    def create(self, validated_data):
        user = validated_data["user"]
        user.set_password(validated_data["password1"])
        user.is_registration_verified = True
        user.save()
        return user


# class UserSerializer(serializers.ModelSerializer):
#     def __init__(self, *args, **kwargs):
#         super().__init__(*args, **kwargs)
#         self.many = self.context.get('many', False)
#         self.request = self.context.get('request')
#         self.query_params = self.request.query_params
#         self.related_field = [field.strip() for field in self.query_params.get('related_field', 'profile, setting').split(',')]

#     liked_dishes = serializers.SerializerMethodField()
#     notifications = serializers.SerializerMethodField()
#     promotions = serializers.SerializerMethodField()
#     rated_dishes = serializers.SerializerMethodField()
#     rated_deliverers = serializers.SerializerMethodField()
#     rated_deliveries = serializers.SerializerMethodField()
#     # orders = serializers.SerializerMethodField()
#     profile = serializers.SerializerMethodField()
#     setting = serializers.SerializerMethodField()

#     class Meta:
#         model = User
#         exclude = ("password", )

#     def serialize_related_object(self, related_serializer, obj, related):
#         if self.request and not self.many:
#             if related in self.related_field:
#                 return related_serializer(obj[related]).data
#             return None
#         return None

#     def get_profile(self, obj):
#         return self.serialize_related_object(ProfileSerializer, obj, 'profile')

#     def get_setting(self, obj):
#         return self.serialize_related_object(SettingSerializer, obj, 'setting')

#     def get_liked_dishes(self, obj):
#         return get_many_related_url(self.request, self.many, obj, 'liked-dishes')

#     def get_rated_dishes(self, obj):
#         return get_many_related_url(self.request, self.many, obj, 'rated-dishes')

#     def get_rated_deliverers(self, obj):
#         return get_many_related_url(self.request, self.many, obj, 'rated-deliverers')

#     def get_rated_deliveries(self, obj):
#         return get_many_related_url(self.request, self.many, obj, 'rated-deliveries')

#     def get_notifications(self, obj):
#         return get_many_related_url(self.request, self.many, obj, 'notifications')

#     def get_promotions(self, obj):
#         return get_many_related_url(self.request, self.many, obj, 'promotions')

#     def to_representation(self, instance):
#         data = super().to_representation(instance)
#         if not data.get('profile'):
#             data.pop('profile')
#         if not data.get('setting'):
#             data.pop('setting')
#         return data
    
    # def get_orders(self, obj):
    #     request = self.context.get('request')
    #     return request.build_absolute_uri(f'/account/user/{obj.pk}/orders')