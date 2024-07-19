# deliverer/admin.py
from django.contrib import admin

class OperationInfoAdmin(admin.ModelAdmin):
    list_display = ['city', 'operation_type', 'operational_area', 'operational_time']
    search_fields = ['city', 'operation_type', 'operational_area']
    list_filter = ['operation_type']
