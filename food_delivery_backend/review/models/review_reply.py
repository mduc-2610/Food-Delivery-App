import uuid
from django.db import models
from django.dispatch import receiver
from django.db.models.signals import post_save, post_delete
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType

from review.models import (
    DishReview,
    RestaurantReview,
    DelivererReview,
    DeliveryReview,
)

class ReviewReply(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", related_name="reply_reviews", on_delete=models.CASCADE)
    title = models.CharField(max_length=255, blank=True, null=True)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True, blank=True)

    class Meta:
        ordering = ('-created_at',)

    def __str__(self):
        return f"Reply by {self.user}"
    

class DishReviewReply(ReviewReply):
    review = models.ForeignKey('review.DishReview', related_name='dish_replies', on_delete=models.CASCADE)

    class Meta:
        verbose_name = "Dish Review Reply"
        verbose_name_plural = "Dish Reply Reviews"

class RestaurantReviewReply(ReviewReply):
    review = models.ForeignKey('review.RestaurantReview', related_name='restaurant_replies', on_delete=models.CASCADE)

    class Meta:
        verbose_name = "Restaurant Review Reply"
        verbose_name_plural = "Restaurant Reply Reviews"

class DelivererReviewReply(ReviewReply):
    review = models.ForeignKey('review.DelivererReview', related_name='deliverer_replies', on_delete=models.CASCADE)

    class Meta:
        verbose_name = "Deliverer Review Reply"
        verbose_name_plural = "Deliverer Reply Reviews"

class DeliveryReviewReply(ReviewReply):
    review = models.ForeignKey('review.DeliveryReview', related_name='delivery_replies', on_delete=models.CASCADE)

    class Meta:
        verbose_name = "Delivery Review Reply"
        verbose_name_plural = "Delivery Reply Reviews"

def update_total_replies(instance, increment=True):
    # if isinstance(instance, DishReviewReply):
    #     parent = instance.dish
    #     review = DishReview.objects.filter(dish=parent).first()
    # elif isinstance(instance, RestaurantReviewReply):
    #     parent = instance.restaurant
    #     review = RestaurantReview.objects.filter(restaurant=parent).first()
    # elif isinstance(instance, DelivererReviewReply):
    #     parent = instance.deliverer
    #     review = DelivererReview.objects.filter(deliverer=parent).first()
    # elif isinstance(instance, DeliveryReviewReply):
    #     parent = instance.delivery
    #     review = DeliveryReview.objects.filter(delivery=parent).first()
    # else:
    #     return
    review = instance.review
    if review:
        if increment:
            review.total_replies += 1
        else:
            review.total_replies = max(0, review.total_replies - 1)
        review.save()

@receiver(post_save, sender=DishReviewReply)
@receiver(post_save, sender=RestaurantReviewReply)
@receiver(post_save, sender=DelivererReviewReply)
@receiver(post_save, sender=DeliveryReviewReply)
def handle_reply_save(sender, instance, created, **kwargs):
    if created:
        update_total_replies(instance, increment=True)

@receiver(post_delete, sender=DishReviewReply)
@receiver(post_delete, sender=RestaurantReviewReply)
@receiver(post_delete, sender=DelivererReviewReply)
@receiver(post_delete, sender=DeliveryReviewReply)
def handle_reply_delete(sender, instance, **kwargs):
    update_total_replies(instance, increment=False)