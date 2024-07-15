from datetime import timedelta
from django.contrib.auth.models import AbstractBaseUser, AbstractUser, BaseUserManager
from django.core.validators import RegexValidator, validate_email
from django.db import models
from django.utils import timezone
import uuid

from rest_framework.settings import api_settings

class UserManager(BaseUserManager):
    def create_user(self, phone_number, password=None):
        if not phone_number:
            raise ValueError('Phone number is required.')
        user = self.model(phone_number=phone_number)
        user.set_password(password)
        user.save(using=self._db)
        return user
    
    def create_superuser(self, phone_number, password):
        user = self.create_user(phone_number, password)
        user.is_active = True
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user

class User(AbstractBaseUser):
    id = models.UUIDField(db_index=True, primary_key=True, default=uuid.uuid4, editable=False)
    phone_regex = RegexValidator(
        regex=r'\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$',
        message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed."
    )
    phone_number = models.CharField(
        max_length=15,
        unique=True,
        validators=[phone_regex],
        help_text="Enter a valid international phone number starting with '+'",
    )
    email = models.EmailField(
        max_length=50,
        blank=True,
        null=True,
        validators=[validate_email]
    )
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    date_joined = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now=True)
    is_otp_verified = models.BooleanField(default=False)
    is_registration_verified = models.BooleanField(default=False)
    USERNAME_FIELD = 'phone_number'

    objects = UserManager()

    def __str__(self):
        return f"{self.phone_number}"

    def has_perm(self, perm, obj=None):
        return self.is_superuser

    def has_module_perms(self, app_label):
        return self.is_superuser
    
class OTP(models.Model):
    id = models.UUIDField(db_index=True, primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey("account.User", on_delete=models.CASCADE)
    code = models.CharField(max_length=4)
    expired_at = models.DateTimeField(blank=True, null=True)

    def save(self, *args, **kwargs):
        interval = api_settings.DEFAULT_THROTTLE_RATES.get('otp', '60s').split('/')[1]
        interval = interval[:-1]
        self.expired_at = timezone.now() + timedelta(seconds=int(interval))
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.user} - {self.code}"