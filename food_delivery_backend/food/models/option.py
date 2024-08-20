import uuid
from django.db import models

class DishOption(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    dish = models.ForeignKey("food.Dish", related_name='options', on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    is_multiple_choice = models.BooleanField(default=True, help_text="Indicates if multiple items can be selected for this option.")

    def __str__(self):
        return f"{self.name} )"


class DishOptionItem(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    option = models.ForeignKey("food.DishOption", related_name='items', on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=6, decimal_places=2)

    def __str__(self):
        return f"{self.name} - {self.price}"