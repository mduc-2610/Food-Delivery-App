import uuid
from django.db import models
from django.contrib.auth.models import User
from django.dispatch import receiver
from django.db.models.signals import post_save, post_delete

class DishLike(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", related_name='dish_likes', on_delete=models.CASCADE)
    dish = models.ForeignKey('food.Dish', related_name='likes', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'dish')
        indexes = [
            models.Index(fields=['user', 'dish']),
        ]
        ordering = ['-created_at']  

    def __str__(self):
        return f"{self.user} likes {self.dish.name}"

@receiver(post_save, sender=DishLike)
def update_total_likes_on_save(sender, instance, created, **kwargs):
    if created:
        instance.dish.total_likes += 1
        instance.dish.save()

@receiver(post_delete, sender=DishLike)
def update_total_likes_on_delete(sender, instance, **kwargs):
    instance.dish.total_likes -= 1
    instance.dish.save()