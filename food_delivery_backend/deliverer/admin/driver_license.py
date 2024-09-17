# deliverer/admin.py
from django.contrib import admin

class DriverLicenseAdmin(admin.ModelAdmin):
    list_display = ['license_plate', 'vehicle_type']
    search_fields = ['license_plate', 'vehicle_type']
    list_filter = ['vehicle_type']
    readonly_fields = ['driver_license_front', 'driver_license_back',]

    def get_readonly_fields(self, request, obj=None):
        if obj:
            return self.readonly_fields + ['driver_license_front', 'driver_license_back',]
        return self.readonly_fields
