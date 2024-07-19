from django.contrib import admin

class PostAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'title', 'created_at']
    search_fields = ['title', 'user__username']
    list_filter = ['created_at']
