# food/admin.py
from django.contrib import admin

class DishLikeAdmin(admin.ModelAdmin):
    list_display = ['user', 'dish', 'created_at']
    search_fields = ['user__username', 'dish__name']
    readonly_fields = ['created_at']
    list_filter = ['created_at']
