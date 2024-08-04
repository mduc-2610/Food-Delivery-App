# restaurant/admin.py
from django.contrib import admin

class RestaurantAdmin(admin.ModelAdmin):
    # list_display = ['id', 'name', 'description']
    # search_fields = ['basic_info__name']
    list_filter = ['user']

class RestaurantCategoryAdmin(admin.ModelAdmin):
    list_display = ('restaurant', 'category', 'created_at')
    search_fields = ('restaurant', 'category')
    list_filter = ('created_at',)
