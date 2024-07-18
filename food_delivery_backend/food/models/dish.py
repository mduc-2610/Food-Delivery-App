import uuid
from django.db import models

class Dish(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    name = models.CharField(max_length=100)
    description = models.TextField()
    original_price = models.DecimalField(max_digits=6, decimal_places=2)
    discount_price = models.DecimalField(max_digits=6, decimal_places=2, null=True, blank=True)
    image = models.ImageField(upload_to='food_images/', null=True, blank=True)
    rating = models.DecimalField(max_digits=3, decimal_places=1, default=0.0)
    number_of_reviews = models.IntegerField(default=0)
    category = models.ForeignKey('food.DishCategory', related_name='dishes', on_delete=models.CASCADE)

    def __str__(self):
        return self.name

