import uuid
from django.db import models

class DishAdditionalOption(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    dish = models.ForeignKey("food.Dish", related_name='additional_options', on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    price = models.DecimalField(max_digits=5, decimal_places=2)
    is_chosen = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.name} (+{self.price})"

class DishSizeOption(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    dish = models.ForeignKey("food.Dish", related_name='size_options', on_delete=models.CASCADE)
    size = models.CharField(max_length=50)
    price = models.DecimalField(max_digits=5, decimal_places=2)
    is_chosen = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.size} ({self.price})"