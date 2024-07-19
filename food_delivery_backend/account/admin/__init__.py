from django.contrib import admin

from .user import (
    UserAdmin, OTPAdmin
)
from .profile import ProfileAdmin
from .setting import SettingAdmin, SecuritySettingAdmin 

from account.models import (
    User, OTP, 
    Profile, 
    Setting, SecuritySetting,
)

admin.site.register(User, UserAdmin)
admin.site.register(OTP, OTPAdmin)
admin.site.register(Profile, ProfileAdmin)
admin.site.register(Setting, SettingAdmin)
admin.site.register(SecuritySetting, SecuritySettingAdmin)
