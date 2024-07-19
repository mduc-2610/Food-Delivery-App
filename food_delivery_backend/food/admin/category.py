# food/admin.py
from django.contrib import admin

class DishCategoryAdmin(admin.ModelAdmin):
    list_display = ['name', 'description', 'created_at', 'updated_at', 'dish_count']
    search_fields = ['name', 'description']
    readonly_fields = ['created_at', 'updated_at']
    
    def dish_count(self, obj):
        return obj.dish_count()
    dish_count.admin_order_field = 'dishes'  
