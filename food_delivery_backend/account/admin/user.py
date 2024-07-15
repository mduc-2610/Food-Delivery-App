from django.contrib import admin

class UserAdmin(admin.ModelAdmin):
    list_display = ['id', 'phone_number', 'email', 'is_active', 'is_staff', 'is_superuser', 'date_joined', 'last_login']
    
class OTPAdmin(admin.ModelAdmin):
    list_display = ['user', 'code', 'expired_at']