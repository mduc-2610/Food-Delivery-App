# delivery/admin.py
from django.contrib import admin

class DeliveryAdmin(admin.ModelAdmin):
    list_display = ['id', 'order', 'deliverer', 'pickup_location', 'dropoff_location', 'status', 
                    'estimated_delivery_time', 'actual_delivery_time', 'started_at', 'finished_at']
    search_fields = ['order__id', 'deliverer__user__username']
    list_filter = ['status', 'started_at', 'finished_at']
    readonly_fields = ['started_at', 'finished_at']
