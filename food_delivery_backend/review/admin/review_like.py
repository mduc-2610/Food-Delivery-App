from django.contrib import admin

class DishReviewLikeAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'review', 'created_at']
    search_fields = ['user__username', 'review__id']
    list_filter = ['created_at']

class RestaurantReviewLikeAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'review', 'created_at']
    search_fields = ['user__username', 'review__id']
    list_filter = ['created_at']

class DelivererReviewLikeAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'review', 'created_at']
    search_fields = ['user__username', 'review__id']
    list_filter = ['created_at']

class OrderReviewLikeAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'review', 'created_at']
    search_fields = ['user__username', 'review__id']
    list_filter = ['created_at']
