# order/admin.py
from django.contrib import admin

class OrderAdmin(admin.ModelAdmin):
    list_display = ['id', 'cart', 'delivery_address', 'payment_method', 'promotion', 
                    'delivery_fee', 'discount', 'total', 'status']
    search_fields = ['cart__user__username', 'delivery_address']
    list_filter = ['status', 'payment_method']
    readonly_fields = ['total']
