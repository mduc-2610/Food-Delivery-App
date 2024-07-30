import uuid
from django.db import models

class Review(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    rating = models.PositiveSmallIntegerField(blank=True, null=True)
    title = models.CharField(max_length=255, blank=True, null=True)
    content = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True
        ordering = ('-created_at')

    def __str__(self):
        return f"{self.title}'s review"

class DishReview(Review):
    user = models.ForeignKey("account.User", related_name="dish_reviews", on_delete=models.CASCADE)
    dish = models.ForeignKey("food.Dish", related_name='dish_reviews', on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'dish')

    def __str__(self):
        return f"{self.user}'s review of {self.dish}"

class DelivererReview(Review):
    user = models.ForeignKey("account.User", related_name="deliverer_reviews", on_delete=models.CASCADE)
    deliverer = models.ForeignKey("deliverer.Deliverer", related_name='deliverer_reviews', on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'deliverer')

    def __str__(self):
        return f"{self.user}'s review of {self.deliverer}"

class RestaurantReview(Review):
    user = models.ForeignKey("account.User", related_name="restaurant_reviews", on_delete=models.CASCADE)
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name='restaurant_reviews', on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'restaurant')

    def __str__(self):
        return f"{self.user}'s review of {self.restaurant}"

class DeliveryReview(Review):
    user = models.ForeignKey("account.User", related_name="delivery_reviews", on_delete=models.CASCADE)
    delivery = models.ForeignKey("order.Delivery", related_name='delivery_reviews', on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'delivery')

    def __str__(self):
        return f"{self.user}'s review of {self.delivery}"
