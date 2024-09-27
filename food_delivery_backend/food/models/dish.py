import uuid
import os
from django.db import models
from django.utils import timezone

def image_upload_path(instance, filename):
    dish = instance.dish if hasattr(instance, 'dish') else instance
    id = dish.id
    now = timezone.now()
    # category_name = dish.category.name.lower().replace(" ", "_")
    return os.path.join(
        'food',
        now.strftime("%Y/%m/%d"), 
        str(id), 
        filename,
    )

def default_rating_counts(): 
    return {
        "1": 0,
        "2": 0,
        "3": 0,
        "4": 0,
        "5": 0
    }

class Dish(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    name = models.CharField(max_length=100)
    description = models.TextField()
    original_price = models.DecimalField(max_digits=6, decimal_places=2)
    discount_price = models.DecimalField(max_digits=6, decimal_places=2, null=True, blank=True)
    image = models.ImageField(upload_to=image_upload_path, null=True, blank=True)
    category = models.ForeignKey("food.DishCategory", related_name="dishes", on_delete=models.CASCADE)
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name="dishes", on_delete=models.CASCADE, null=True)
    is_disabled = models.BooleanField(default=False, blank=True,)
    rating_counts = models.JSONField(default=default_rating_counts, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True, blank=True)

    rating = models.DecimalField(max_digits=3, decimal_places=1, default=0, blank=True, null=True)
    total_reviews = models.IntegerField(default=0, blank=True, null=True)
    total_likes = models.IntegerField(default=0, blank=True, null=True)
    total_orders = models.IntegerField(default=0, blank=True, null=True)

    class Meta:
        ordering = ['-created_at']
        
    def __getitem__(self, attr):
        if hasattr(self, attr):
            return getattr(self, attr)
        else:
            raise AttributeError(f"{attr} is not a valid attribute")

    def __str__(self):
        return self.name

class DishImage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    image = models.ImageField(upload_to=image_upload_path)
    dish = models.ForeignKey("food.Dish", related_name="images", on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.dish.name} Image"