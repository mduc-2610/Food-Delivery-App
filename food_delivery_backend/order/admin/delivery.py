# delivery/admin.py
from django.contrib import admin

class DeliveryAdmin(admin.ModelAdmin):
    list_display = ['id', 'order', 'deliverer', 'pickup_location', 'dropoff_location', 'status', 
                    'estimated_delivery_time', 'actual_delivery_time', 'created_at', 'updated_at']
    search_fields = ['order__id', 'deliverer__user__username']
    list_filter = ['status', 'created_at', 'updated_at']
    readonly_fields = ['created_at', 'updated_at']
