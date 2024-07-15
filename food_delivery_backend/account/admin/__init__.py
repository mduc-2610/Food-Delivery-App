from django.contrib import admin

from .user import UserAdmin, OTPAdmin

from account.models import User, OTP

admin.site.register(User, UserAdmin)
admin.site.register(OTP, OTPAdmin)