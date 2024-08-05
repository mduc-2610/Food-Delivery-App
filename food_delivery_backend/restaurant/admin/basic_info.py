# basicinfo/admin.py
from django.contrib import admin

class BasicInfoAdmin(admin.ModelAdmin):
    list_display = ['name', 'phone_number', 'city', 'district', 'street_address', 'latitude', 'longitude']
    search_fields = ['name', 'phone_number', 'city']
    list_filter = ['city', 'district']
