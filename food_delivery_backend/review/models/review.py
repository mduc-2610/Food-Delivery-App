import uuid
from django.db import models
from django.db.models import Avg
from django.dispatch import receiver
from django.db.models.signals import post_save, post_delete
from django.apps import apps
from django.contrib.auth.models import AnonymousUser
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType


from review.models.review_like import (
    DishReviewLike,
    RestaurantReviewLike,
    DelivererReviewLike,
    DeliveryReviewLike,
)

class Review(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    rating = models.PositiveSmallIntegerField(default=0 ,blank=True, null=True)
    title = models.CharField(max_length=255, blank=True, null=True)
    content = models.TextField(default="")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    total_likes = models.IntegerField(default=0, blank=True, null=True)
    total_replies = models.IntegerField(default=0, blank=True, null=True)

    class Meta:
        abstract = True
        ordering = ('-created_at',)

    def __str__(self):
        return f"{self.title}'s review"

class DishReview(Review):
    user = models.ForeignKey("account.User", related_name="dish_reviews", on_delete=models.CASCADE)
    dish = models.ForeignKey("food.Dish", related_name='dish_reviews', on_delete=models.CASCADE)
    order = models.ForeignKey("order.Order", related_name='dish_reviews', on_delete=models.CASCADE, blank=True, null=True)
    
    def is_liked(self, user=None, request=None):
        _user = user if user else getattr(request, 'user') if hasattr(request, 'user') else None
        if _user and not isinstance(_user, AnonymousUser):
            return DishReviewLike.objects.filter(user=_user, review=self).exists()
        return False
    
    # class Meta:
    #     unique_together = ['user', 'dish', 'order']

    def __str__(self):
        return f"{self.user}'s review of {self.dish}"

class DelivererReview(Review):
    user = models.ForeignKey("account.User", related_name="deliverer_reviews", on_delete=models.CASCADE)
    deliverer = models.ForeignKey("deliverer.Deliverer", related_name='deliverer_reviews', on_delete=models.CASCADE, blank=True, null=True)
    order = models.OneToOneField("order.Order", related_name='deliverer_review', on_delete=models.CASCADE, blank=True, null=True)

    def is_liked(self, user=None, request=None):
        _user = user if user else getattr(request, 'user') if hasattr(request, 'user') else None
        if _user and not isinstance(_user, AnonymousUser):
            return DelivererReviewLike.objects.filter(user=_user, review=self).exists()
        return False
    
    # class Meta:
    #     unique_together = ['user', 'deliverer', 'order']

    def __str__(self):
        return f"{self.user}'s review of {self.deliverer}"

class RestaurantReview(Review):
    user = models.ForeignKey("account.User", related_name="restaurant_reviews", on_delete=models.CASCADE)
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name='restaurant_reviews', on_delete=models.CASCADE)
    order = models.OneToOneField("order.Order", related_name='restaurant_review', on_delete=models.CASCADE, blank=True, null=True)

    def is_liked(self, user=None, request=None):
        _user = user if user else getattr(request, 'user') if hasattr(request, 'user') else None
        if _user and not isinstance(_user, AnonymousUser):
            return RestaurantReviewLike.objects.filter(user=_user, review=self).exists()
        return False
    
    # class Meta:
    #     unique_together = ['user', 'restaurant', 'order']

    def __str__(self):
        return f"{self.user}'s review of {self.restaurant}"

class DeliveryReview(Review):
    user = models.ForeignKey("account.User", related_name="delivery_reviews", on_delete=models.CASCADE)
    delivery = models.ForeignKey("order.Delivery", related_name='delivery_reviews', on_delete=models.CASCADE)
    order = models.OneToOneField("order.Order", related_name='delivery_review', on_delete=models.CASCADE, blank=True, null=True)

    def is_liked(self, user=None, request=None):
        _user = user if user else getattr(request, 'user') if hasattr(request, 'user') else None
        if _user and not isinstance(_user, AnonymousUser):
            return DeliveryReviewLike.objects.filter(user=_user, review=self).exists()
        return False
    
    # class Meta: 
    #     unique_together = ['user', 'delivery', 'order']

    def __str__(self):
        return f"{self.user}'s review of {self.delivery}"
    
def update_review_stats(instance, created=False, deleted=False):
    if isinstance(instance, DishReview):
        model_name = 'Dish'
        related_field = 'dish'
    elif isinstance(instance, RestaurantReview):
        model_name = 'Restaurant'
        related_field = 'restaurant'
    elif isinstance(instance, DelivererReview):
        model_name = 'Deliverer'
        related_field = 'deliverer'
    else:
        raise ValueError("Unknown review type")

    related_model = getattr(instance, related_field)
    
    Review = apps.get_model('review', f'{model_name}Review')
    reviews = Review.objects.filter(**{related_field: related_model})
    
    related_model.total_reviews = reviews.count()
    
    rating_counts = {str(i): 0 for i in range(1, 6)}  
    for review in reviews:
        if review.rating:
            rating_key = str(int(review.rating))
            rating_counts[rating_key] += 1
    related_model.rating_counts = rating_counts
    
    average_rating = reviews.aggregate(Avg('rating'))['rating__avg']
    related_model.rating = average_rating or 0
    
    related_model.save()

@receiver(post_save, sender=DishReview)
@receiver(post_save, sender=RestaurantReview)
@receiver(post_save, sender=DelivererReview)
def update_review_save(sender, instance, created, **kwargs):
    update_review_stats(instance, created=created)

@receiver(post_delete, sender=DishReview)
@receiver(post_delete, sender=RestaurantReview)
@receiver(post_delete, sender=DelivererReview)
def update_review_delete(sender, instance, **kwargs):
    update_review_stats(instance, deleted=True)

