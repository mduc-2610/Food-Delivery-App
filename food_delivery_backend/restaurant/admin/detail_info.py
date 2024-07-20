# detailinformation/admin.py
from django.contrib import admin

class DetailInfoAdmin(admin.ModelAdmin):
    list_display = [
        'keywords', 'restaurant_type', 'cuisine', 'specialty_dishes', 
        'serving_times', 'target_audience', 'restaurant_category', 'purpose'
    ]
    search_fields = ['keywords', 'restaurant_type', 'cuisine', 'specialty_dishes']
    list_filter = ['restaurant_type', 'cuisine']
