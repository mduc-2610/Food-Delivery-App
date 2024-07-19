# menudelivery/admin.py
from django.contrib import admin

class MenuDeliveryAdmin(admin.ModelAdmin):
    list_display = ['id', 'menu_image']
    search_fields = ['id']
