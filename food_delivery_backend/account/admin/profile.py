from django.contrib import admin

class ProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'name', 'gender', 'date_of_birth']
    search_fields = ['name', 'user__username', 'user__email']

class LocationAdmin(admin.ModelAdmin):
    list_display = ['profile', 'address', 'latitude', 'longitude']
    search_fields = ['address', 'profile__name', 'profile__user__username']
