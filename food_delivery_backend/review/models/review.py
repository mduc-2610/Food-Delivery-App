import uuid
from django.db import models

class Review(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", related_name='%(class)s_reviews', on_delete=models.CASCADE)
    rating = models.PositiveSmallIntegerField()
    title = models.CharField(max_length=255, blank=True, null=True)
    comment = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True
        ordering = ('-created_at')

    def __str__(self):
        return f"{self.user.username}'s review"

class DishReview(Review):
    dish = models.ForeignKey("food.Dish", related_name='user_reviews', on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'dish')

    def __str__(self):
        return f"{self.user}'s review of {self.dish}"

class DelivererReview(Review):
    deliverer = models.ForeignKey("deliverer.Deliverer", related_name='user_reviews', on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'deliverer')

    def __str__(self):
        return f"{self.user}'s review of {self.deliverer}"

class RestaurantReview(Review):
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name='user_reviews', on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'restaurant')

    def __str__(self):
        return f"{self.user}'s review of {self.restaurant}"

class OrderReview(Review):
    order = models.ForeignKey("order.Order", related_name='user_reviews', on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'order')

    def __str__(self):
        return f"{self.user}'s review of {self.order}"