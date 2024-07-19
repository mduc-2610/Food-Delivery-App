from django.contrib import admin
from account.models import Profile

class ProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'name', 'gender', 'location', 'date_of_birth']
    search_fields = ['user__username', 'name', 'location']
