from django.contrib import admin

class LikeAdmin(admin.ModelAdmin):
    list_display = ['id', 'post', 'user', 'created_at']
    search_fields = ['user__username', 'post__title']
    list_filter = ['created_at']
