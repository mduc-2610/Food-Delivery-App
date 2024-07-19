from django.contrib import admin

class CommentAdmin(admin.ModelAdmin):
    list_display = ['id', 'post', 'user', 'text', 'created_at']
    search_fields = ['text', 'user__username', 'post__title']
    list_filter = ['created_at']
