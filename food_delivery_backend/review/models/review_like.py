import uuid
from django.db import models
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver

class ReviewLike(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        abstract = True
        indexes = [
            models.Index(fields=['user', 'review']),
        ]
        # unique_together = ('user', 'review')
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

def update_total_likes(instance, created=False, deleted=False):
    review = instance.review
    if created:
        review.total_likes += 1
    elif deleted:
        review.total_likes = max(0, review.total_likes - 1)
    
    review.save()

@receiver(post_save, sender=DishReviewLike)
@receiver(post_save, sender=RestaurantReviewLike)
@receiver(post_save, sender=DelivererReviewLike)
@receiver(post_save, sender=DeliveryReviewLike)
def update_like_save(sender, instance, created, **kwargs):
    update_total_likes(instance, created=created)

@receiver(post_delete, sender=DishReviewLike)
@receiver(post_delete, sender=RestaurantReviewLike)
@receiver(post_delete, sender=DelivererReviewLike)
@receiver(post_delete, sender=DeliveryReviewLike)
def update_like_delete(sender, instance, **kwargs):
    update_total_likes(instance, deleted=True)