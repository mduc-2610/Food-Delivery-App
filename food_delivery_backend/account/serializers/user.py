import random
from django.core.validators import RegexValidator
from django.utils import timezone

from rest_framework import serializers

from account.models import User, OTP, Location

from utils.regex_validators import phone_regex, password_regex

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['id', 'address', 'latitude', 'longitude']

class UserSerializer(serializers.ModelSerializer):
    locations = LocationSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = "__all__"

class OTPSerializer(serializers.ModelSerializer):
    class Meta:
        model = OTP
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }

class SendOTPSerializer(serializers.Serializer):
    phone_number = serializers.CharField(validators=[phone_regex], max_length=16, write_only=True)
    
    def validate(self, data):
        phone_number = data.get("phone_number")
        otp = OTP.objects.filter(user__phone_number=phone_number).first()

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
            'user': UserSerializer(user).data
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
