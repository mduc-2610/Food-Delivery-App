# food/admin.py
from django.contrib import admin
from food.models import Dish, DishAdditionalOption, DishSizeOption

class DishSizeOptionInline(admin.TabularInline):
    model = DishSizeOption
    extra = 1

class DishAdditionalOptionInline(admin.TabularInline):
    model = DishAdditionalOption
    extra = 1
    
class DishAdmin(admin.ModelAdmin):
    list_display = ['name', 'original_price', 'discount_price', 'rating', 'total_reviews', 'category']
    search_fields = ['name', 'description', 'category__name']
    list_filter = ['category', 'rating']
    readonly_fields = ['rating', 'total_reviews']
