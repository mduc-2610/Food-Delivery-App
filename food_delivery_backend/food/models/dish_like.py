from django.db import models
from django.contrib.auth.models import User

class DishLike(models.Model):
    user = models.ForeignKey("account.User", related_name='dish_likes', on_delete=models.CASCADE)
    dish = models.ForeignKey('food.Dish', related_name='likes', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'dish')
        ordering = ['-created_at']  

    def __str__(self):
        return f"{self.user} likes {self.dish.name}"
