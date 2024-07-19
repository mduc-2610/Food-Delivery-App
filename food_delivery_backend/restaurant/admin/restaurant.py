# restaurant/admin.py
from django.contrib import admin

class RestaurantAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'description']
    search_fields = ['basic_info__name']
    list_filter = ['user']
