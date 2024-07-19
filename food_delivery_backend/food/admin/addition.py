# food/admin.py
from django.contrib import admin

class DishAdditionalOptionAdmin(admin.ModelAdmin):
    list_display = ['dish', 'name', 'price']
    search_fields = ['name', 'dish__name']
    list_filter = ['dish']
