# reviews/admin.py
from django.contrib import admin
from review.models import DishReview, DelivererReview, RestaurantReview, DeliveryReview

class DishReviewAdmin(admin.ModelAdmin):
    list_display = ['user', 'dish', 'rating', 'created_at']
    search_fields = ['user__username', 'dish__name']

class DelivererReviewAdmin(admin.ModelAdmin):
    list_display = ['user', 'deliverer', 'rating', 'created_at']
    search_fields = ['user__username', 'deliverer__name']

class RestaurantReviewAdmin(admin.ModelAdmin):
    list_display = ['user', 'restaurant', 'rating', 'created_at']
    search_fields = ['user__username', 'restaurant__name']

class DeliveryReviewAdmin(admin.ModelAdmin):
    list_display = ['user', 'delivery', 'rating', 'created_at']
    search_fields = ['user__username', 'order__id']
