# order/admin.py
from django.contrib import admin

class CartAdmin(admin.ModelAdmin):
    list_display = ['user', 'created_at', 'updated_at']
    search_fields = ['user__username']
    readonly_fields = ['created_at', 'updated_at']

class RestaurantCartAdmin(admin.ModelAdmin):
    list_display = ['cart', 'restaurant', 'created_at', 'updated_at', 'is_placed_order', 'raw_fee']
    search_fields = ['cart__user__username', 'restaurant__name']
    list_filter = ['is_placed_order']
    readonly_fields = ['created_at', 'updated_at']

class RestaurantCartDishAdmin(admin.ModelAdmin):
    list_display = ['cart', 'dish', 'quantity', 'price']
    search_fields = ['dish__name']
    readonly_fields = ['price']
