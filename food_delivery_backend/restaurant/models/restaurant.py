import uuid
from django.db import models

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
    restaurant = models.ForeignKey("restaurant.Restaurant", on_delete=models.CASCADE, related_name="restaurant_categories")
    category = models.ForeignKey("food.DishCategory", on_delete=models.CASCADE, related_name="restaurant_categories")
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"{self.restaurant} - {self.category}"
