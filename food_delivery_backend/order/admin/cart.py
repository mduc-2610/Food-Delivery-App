# order/admin.py
from django.contrib import admin

class RestaurantCartAdmin(admin.ModelAdmin):
    list_display = ['user', 'restaurant', 'created_at', 'updated_at', 'total_price']
    search_fields = ['user__phone_number', 'restaurant__name']
    readonly_fields = ['created_at', 'updated_at']

class RestaurantCartDishAdmin(admin.ModelAdmin):
    list_display = ['cart', 'dish', 'quantity', 'price']
    search_fields = ['dish__name']
    readonly_fields = ['price']
