# food/admin.py
from django.contrib import admin
from food.models import Dish

class DishAdmin(admin.ModelAdmin):
    list_display = ['name', 'original_price', 'discount_price', 'rating', 'total_reviews', 'category']
    search_fields = ['name', 'description', 'category__name']
    list_filter = ['category', 'rating']
    readonly_fields = ['rating', 'total_reviews']
