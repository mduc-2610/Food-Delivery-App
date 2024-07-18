from django.db import models

class DishAdditionalOption(models.Model):
    dish = models.ForeignKey("food.Dish", related_name='options', on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    price = models.DecimalField(max_digits=5, decimal_places=2)

    def __str__(self):
        return f"{self.name} (+{self.price})"
