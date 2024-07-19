# food/admin.py
from django.contrib import admin

class DishAdmin(admin.ModelAdmin):
    list_display = ['name', 'original_price', 'discount_price', 'rating', 'number_of_reviews', 'category']
    search_fields = ['name', 'description', 'category__name']
    list_filter = ['category', 'rating']
    readonly_fields = ['rating', 'number_of_reviews']
