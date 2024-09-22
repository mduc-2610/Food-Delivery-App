# representatives/admin.py
from django.contrib import admin

class RepresentativeInfoAdmin(admin.ModelAdmin):
    list_display = ['id', 'registration_type', 'full_name', 'email', 'phone_number']
    search_fields = ['full_name', 'email', 'phone_number']
    list_filter = ['registration_type']
