# addresses/admin.py
from django.contrib import admin

class AddressAdmin(admin.ModelAdmin):
    list_display = ['city', 'district', 'ward', 'detail_address']
    search_fields = ['city', 'district', 'ward', 'detail_address']
