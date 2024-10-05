# promotion/admin.py
from django.contrib import admin
from order.models import RestaurantPromotion, ActivityPromotion

class RestaurantPromotionAdmin(admin.ModelAdmin):
    list_display = [
        'id', 'code', 'description', 'promo_type', 
        'discount_percentage', 'discount_amount', 
        'start_date', 'end_date', 'applicable_scope', 
        'terms_and_conditions', 'active', 'is_active'
    ]
    search_fields = ['code', 'description', 'promo_type']
    list_filter = ['promo_type', 'active', 'start_date', 'end_date']
    readonly_fields = ['is_active']

class ActivityPromotionAdmin(admin.ModelAdmin):
    list_display = ['promotion', 'activity_type']
    search_fields = ['promotion__code', 'activity_type']
    list_filter = ['activity_type']
