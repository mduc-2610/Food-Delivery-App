# deliverer/admin.py
from django.contrib import admin

class ResidencyInfoAdmin(admin.ModelAdmin):
    list_display = ['city', 'district', 'ward', 'address', 'tax_code', 'email']
    search_fields = ['city', 'district', 'ward', 'address', 'tax_code', 'email']
    list_filter = ['is_same_as_ci']
