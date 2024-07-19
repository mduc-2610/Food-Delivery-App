# basicinfo/admin.py
from django.contrib import admin

class BasicInfoAdmin(admin.ModelAdmin):
    list_display = ['full_name', 'given_name', 'gender', 'date_of_birth', 'hometown', 'city', 'district', 'ward', 'address', 'citizen_identification']
    search_fields = ['full_name', 'given_name', 'hometown', 'city', 'district', 'ward', 'address', 'citizen_identification']
