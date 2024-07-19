# social/admin.py
from django.contrib import admin

class PostImageAdmin(admin.ModelAdmin):
    list_display = ['post', 'image']
    search_fields = ['post__title']

class CommentImageAdmin(admin.ModelAdmin):
    list_display = ['comment', 'image']
    search_fields = ['comment__user__username']
