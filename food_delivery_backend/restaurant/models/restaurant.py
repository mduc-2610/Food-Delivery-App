import uuid
from django.db import models
from django.dispatch import receiver
from django.db.models.signals import (
    post_save,
    post_delete,
)

from food.models import Dish

def default_rating_counts(): 
    return {
        "1": 0,
        "2": 0,
        "3": 0,
        "4": 0,
        "5": 0
    }

class Restaurant(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="restaurant")
    rating = models.DecimalField(max_digits=3, decimal_places=1, default=0, blank=True, null=True)
    total_reviews = models.IntegerField(default=0, blank=True, null=True)
    rating_counts = models.JSONField(default=default_rating_counts, blank=True, null=True)

    promotions = models.ManyToManyField("order.Promotion", through="order.RestaurantPromotion", related_name="promotions")
    categories = models.ManyToManyField("food.DishCategory", through="restaurant.RestaurantCategory", related_name="restaurants")

    avg_price = models.DecimalField(max_digits=9, decimal_places=2, default=0.00, blank=True, null=True)
    total_likes = models.IntegerField(default=0, blank=True, null=True)

    def is_liked(self, user=None, request=None):
        _user = user if user else getattr(request, 'user') if hasattr(request, 'user') else None
        from django.contrib.auth.models import AnonymousUser
        if _user and not isinstance(_user, AnonymousUser):
            return RestaurantLike.objects.filter(user=_user, restaurant=self).exists()
        return False
    
    @property
    def is_certified(self):
        return hasattr(self, 'basic_info') \
            and hasattr(self, 'detail_info') \
            and hasattr(self, 'payment_info') \
            and hasattr(self, 'representative_info') \
            and hasattr(self, 'menu_delivery')

    def name(self):
        if hasattr(self, "basic_info"):
            return self.basic_info.name
        return None

    def description(self):
        if hasattr(self, "detail_info"):
            return self.detail_info.description
        return None

    def __getitem__(self, attr):
        if hasattr(self, attr):
            return getattr(self, attr)
        else:
            raise AttributeError(f"{attr} is not a valid attribute")

    def __str__(self):
        return f"{self.id}"
    
class RestaurantCategory(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    restaurant = models.ForeignKey("restaurant.Restaurant", on_delete=models.CASCADE, related_name="restaurant_categories")
    category = models.ForeignKey("food.DishCategory", on_delete=models.CASCADE, related_name="restaurant_categories")
    created_at = models.DateTimeField(auto_now_add=True, blank=True)
    is_disabled = models.BooleanField(default=False, blank=True)

    def save(self, *args, **kwargs):
        if self.pk:
            Dish.objects.filter(restaurant=self.restaurant, category=self.category).update(is_disabled=self.is_disabled)
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.restaurant} - {self.category}"


class RestaurantLike(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", related_name='restaurant_likes', on_delete=models.CASCADE)
    restaurant = models.ForeignKey('restaurant.Restaurant', related_name='likes', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        unique_together = ('user', 'restaurant')
        indexes = [
            models.Index(fields=['user', 'restaurant']),
        ]
        ordering = ['-created_at']  

    def __str__(self):
        return f"{self.user} likes {self.restaurant.name}"

@receiver(post_save, sender="restaurant.RestaurantLike")
def update_total_likes_on_save(sender, instance, created, **kwargs):
    if created:
        instance.restaurant.total_likes += 1
        instance.restaurant.save()

@receiver(post_delete, sender="restaurant.RestaurantLike")
def update_total_likes_on_delete(sender, instance, **kwargs):
    instance.restaurant.total_likes -= 1
    instance.restaurant.save()
