from django.contrib import admin
from food.models import DishOptionItem

class DishOptionItemInline(admin.TabularInline):
    model = DishOptionItem
    extra = 1

class DishOptionAdmin(admin.ModelAdmin):
    list_display = ['dish',]
    # inlines = [DishOptionItemInline]

class DishOptionItemAdmin(admin.ModelAdmin):
    list_display = ['option', 'name', 'price']