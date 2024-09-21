# deliverer/admin.py
from django.contrib import admin

class OperationInfoAdmin(admin.ModelAdmin):
    list_display = ['city', 'driver_type', 'area', 'time']
    search_fields = ['city', 'driver_type', 'area']
    list_filter = ['driver_type']
