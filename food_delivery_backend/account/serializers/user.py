import random
from django.core.validators import RegexValidator
from django.utils import timezone

from rest_framework import serializers
from rest_framework.reverse import reverse

from account.models import User, OTP, Location

from utils.regex_validators import phone_regex, password_regex

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['id', 'address', 'latitude', 'longitude']

class UserSerializer(serializers.ModelSerializer):
    liked_dishes = serializers.SerializerMethodField()
    notifications = serializers.SerializerMethodField()
    promotions = serializers.SerializerMethodField()
    rated_dishes = serializers.SerializerMethodField()
    rated_deliverers = serializers.SerializerMethodField()
    # orders = serializers.SerializerMethodField()

    class Meta:
        model = User
        exclude = ("password", )

    def get_related_url(self, obj, view_name):
        request = self.context.get('request')
        if request:
            return request.build_absolute_uri(f'{obj.pk}/{view_name}')
        return None

    def get_liked_dishes(self, obj):
        return self.get_related_url(obj, 'liked-dishes')

    def get_rated_dishes(self, obj):
        return self.get_related_url(obj, 'rated-dishes')

    def get_rated_deliverers(self, obj):
        return self.get_related_url(obj, 'rated-deliverers')

    def get_notifications(self, obj):
        return self.get_related_url(obj, 'notifications')

    def get_promotions(self, obj):
        return self.get_related_url(obj, 'promotions')

    # def get_orders(self, obj):
    #     request = self.context.get('request')
    #     return request.build_absolute_uri(f'/account/user/{obj.pk}/orders')

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
        print(f"Is Forgot Password: {is_forgot_password}")
        print(f"Phone Number: {phone_number}")
        print(f"User: {user}")
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
            'user': UserSerializer(user, context={
                'many_related': False
            }).data
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
