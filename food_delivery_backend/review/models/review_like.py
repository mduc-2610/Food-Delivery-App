import uuid
from django.db import models

class ReviewLike(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        abstract = True
        unique_together = ('user', 'review')
        ordering = ('-created_at',)

    def __str__(self):
        return f"{self.id}"

class DishReviewLike(ReviewLike):
    user = models.ForeignKey("account.User", related_name="dish_review_likes", on_delete=models.CASCADE)
    review = models.ForeignKey("review.DishReview", related_name='dish_review_likes', on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user} liked the dish review: {self.review}"

class RestaurantReviewLike(ReviewLike):
    user = models.ForeignKey("account.User", related_name="restaurant_review_likes", on_delete=models.CASCADE)
    review = models.ForeignKey("review.RestaurantReview", related_name='restaurant_review_likes', on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user} liked the restaurant review: {self.review}"

class DelivererReviewLike(ReviewLike):
    user = models.ForeignKey("account.User", related_name="deliverer_review_likes", on_delete=models.CASCADE)
    review = models.ForeignKey("review.DelivererReview", related_name='deliverer_review_likes', on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user} liked the deliverer review: {self.review}"

class DeliveryReviewLike(ReviewLike):
    user = models.ForeignKey("account.User", related_name="delivery_review_likes", on_delete=models.CASCADE)
    review = models.ForeignKey("review.DeliveryReview", related_name='delivery_review_likes', on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user} liked the delivery review: {self.review}"
