# deliverer/admin.py
from django.contrib import admin

class EmergencyContactAdmin(admin.ModelAdmin):
    list_display = ['name', 'relationship', 'phone_number']
    search_fields = ['name', 'relationship', 'phone_number']
