# deliverer/admin.py
from django.contrib import admin

class DelivererAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'basic_info', 'residency_info', 'driver_license_and_vehicle', 'other_info', 'address', 'operation_info', 'emergency_contact']
    search_fields = ['user__username', 'basic_info__email']
    
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        return queryset.select_related('basic_info', 'residency_info', 'driver_license_and_vehicle', 'other_info', 'address', 'operation_info', 'emergency_contact')
