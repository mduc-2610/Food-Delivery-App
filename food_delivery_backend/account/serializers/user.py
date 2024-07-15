from django.core.validators import RegexValidator
from rest_framework import serializers

from account.models import User, OTP
import random
from django.utils import timezone

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"

class SendOTPSerializer(serializers.Serializer):
    phone_regex = RegexValidator(
        regex=r"\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$",
        message="Phone number must be entered in the format: +999999999. Up to 15 digits allowed."
    )
    phone_number = serializers.CharField(validators=[phone_regex], max_length=16)

    def create(self, validated_data):
        phone_number = validated_data["phone_number"]
        user, created = User.objects.get_or_create(phone_number=phone_number)
        code = str(random.randint(1000, 9999))
        if created:
            otp = OTP.objects.create(user=user, code=code)
        else:
            otp = OTP.objects.filter(user=user).first()
            if otp:
                otp.code = code
                otp.save()
            else:
                otp = OTP.objects.create(user=user, code=code)
        return otp


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
        else:
            self._validate_login(user)

        return data

    def _validate_registration(self, user):
        """Validate the user's registration status."""
        if user.is_registration_verified and user.password:
            raise serializers.ValidationError("User's phone number has already been registered.")
        user.is_otp_verified = True
        user.save()

    def _validate_login(self, user):
        """Validate the user's login status."""
        if not user.is_registration_verified and not user.password:
            raise serializers.ValidationError("User's phone number has not been registered yet.")
        

class RegisterSerializer(serializers.ModelSerializer):
    password_regex = RegexValidator(
        regex=r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$",
        message="Password must contain at least 8 characters, including uppercase, lowercase letters, and numbers."
    )
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
        if not data["user"].is_otp_verified:
            raise serializers.ValidationError("User's phone number is not verified.")
        return data
    
    def create(self, validated_data):
        user = validated_data["user"]
        user.set_password(validated_data["password1"])
        user.is_registration_verified = True
        user.is_otp_verified = False
        user.save()
        return user
