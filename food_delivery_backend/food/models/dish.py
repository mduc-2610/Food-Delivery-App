import uuid
import os
from django.db import models
from django.utils import timezone

from food.models.dish_like import DishLike

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
    total_revenue = models.DecimalField(default=0, max_digits=12, decimal_places=2, blank=True, null=True)
    optimal_temp = models.DecimalField(
        max_digits=5, decimal_places=2, null=True, blank=True,
        help_text="The ideal temperature (°C) for this dish."
    )
    temp_tolerance = models.DecimalField(
        max_digits=5, decimal_places=2, null=True, blank=True,
        help_text="The acceptable tolerance for temperature (±°C)."
    )
    # optimal_humidity = models.DecimalField(
    #     max_digits=5, decimal_places=2, null=True, blank=True,
    #     help_text="The ideal humidity (%) for this dish."
    # )
    # humidity_tolerance = models.DecimalField(
    #     max_digits=5, decimal_places=2, null=True, blank=True,
    #     help_text="The acceptable tolerance for humidity (±%)."
    # )

    def calculate_suitability_score(self, temperature=None, humidity=None):
        temp_score = 0
        humidity_score = 0
    
        if self.optimal_temp is not None and self.temp_tolerance is not None:
            optimal_temp = float(self.optimal_temp)
            temp_tolerance = float(self.temp_tolerance)

            temp_diff = abs(temperature - optimal_temp)
            temp_score = max(0, 1 - (temp_diff / temp_tolerance))

        # if self.optimal_humidity is not None and self.humidity_tolerance is not None:
        #     humidity_diff = abs(humidity - self.optimal_humidity)
        #     humidity_score = max(0, 1 - (humidity_diff / self.humidity_tolerance))

        # return (temp_score + humidity_score) / 2
        return temp_score

    class Meta:
        indexes = [
            models.Index(fields=['category', 'restaurant']),
        ]
    #     ordering = ['-created_at']

    def is_liked(self, user=None, request=None):
        _user = user if user else getattr(request, 'user') if hasattr(request, 'user') else None
        from django.contrib.auth.models import AnonymousUser
        if _user and not isinstance(_user, AnonymousUser):
            return DishLike.objects.filter(user=_user, dish=self).exists()
        return False
        
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