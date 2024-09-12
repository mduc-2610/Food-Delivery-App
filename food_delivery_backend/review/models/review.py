import uuid
from django.db import models
from django.db.models import Avg
from django.dispatch import receiver
from django.db.models.signals import post_save, post_delete

class Review(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    rating = models.PositiveSmallIntegerField(default=0 ,blank=True, null=True)
    title = models.CharField(max_length=255, blank=True, null=True)
    content = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True
        ordering = ('-created_at',)

    def __str__(self):
        return f"{self.title}'s review"

class DishReview(Review):
    user = models.ForeignKey("account.User", related_name="dish_reviews", on_delete=models.CASCADE)
    dish = models.ForeignKey("food.Dish", related_name='dish_reviews', on_delete=models.CASCADE)
    order = models.ForeignKey("order.Order", related_name='dish_reviews', on_delete=models.CASCADE, blank=True, null=True)

    class Meta:
        unique_together = ['user', 'dish', 'order']


    def __str__(self):
        return f"{self.user}'s review of {self.dish}"

class DelivererReview(Review):
    user = models.ForeignKey("account.User", related_name="deliverer_reviews", on_delete=models.CASCADE)
    deliverer = models.ForeignKey("deliverer.Deliverer", related_name='deliverer_reviews', on_delete=models.CASCADE, blank=True, null=True)
    order = models.OneToOneField("order.Order", related_name='deliverer_review', on_delete=models.CASCADE, blank=True, null=True)

    class Meta:
        unique_together = ['user', 'deliverer', 'order']

    def __str__(self):
        return f"{self.user}'s review of {self.deliverer}"

class RestaurantReview(Review):
    user = models.ForeignKey("account.User", related_name="restaurant_reviews", on_delete=models.CASCADE)
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name='restaurant_reviews', on_delete=models.CASCADE)
    order = models.OneToOneField("order.Order", related_name='restaurant_review', on_delete=models.CASCADE, blank=True, null=True)

    class Meta:
        unique_together = ['user', 'restaurant', 'order']

    def __str__(self):
        return f"{self.user}'s review of {self.restaurant}"

class DeliveryReview(Review):
    user = models.ForeignKey("account.User", related_name="delivery_reviews", on_delete=models.CASCADE)
    delivery = models.ForeignKey("order.Delivery", related_name='delivery_reviews', on_delete=models.CASCADE)
    order = models.OneToOneField("order.Order", related_name='delivery_review', on_delete=models.CASCADE, blank=True, null=True)

    class Meta: 
        unique_together = ['user', 'delivery', 'order']

    def __str__(self):
        return f"{self.user}'s review of {self.delivery}"
    

@receiver(post_save, sender=DishReview)
def update_dish_review_save(sender, instance, created, **kwargs):
    dish = instance.dish
    if created:
        dish.total_reviews += 1
    if instance.rating:
        dish.rating_counts[str(int(instance.rating))] += 1

    reviews = DishReview.objects.filter(dish=dish)
    average_rating = reviews.aggregate(Avg('rating'))['rating__avg']
    dish.rating = average_rating
    dish.save()

@receiver(post_delete, sender=DishReview)
def update_dish_review_delete(sender, instance, **kwargs):
    dish = instance.dish
    dish.total_reviews -= 1
    if instance.rating:
        dish.rating_counts[str(int(instance.rating))] -= 1

    reviews = DishReview.objects.filter(dish=dish)
    average_rating = reviews.aggregate(Avg('rating'))['rating__avg']
    dish.rating = average_rating
    dish.save()

"""
"""

@receiver(post_save, sender=RestaurantReview)
def update_restaurant_review_save(sender, instance, created, **kwargs):
    restaurant = instance.restaurant
    if created:
        restaurant.total_reviews += 1
    if instance.rating:
        restaurant.rating_counts[str(instance.rating)] += 1

    reviews = RestaurantReview.objects.filter(restaurant=restaurant)
    average_rating = reviews.aggregate(Avg('rating'))['rating__avg']
    restaurant.rating = average_rating
    restaurant.save()

@receiver(post_delete, sender=RestaurantReview)
def update_restaurant_review_delete(sender, instance, **kwargs):
    restaurant = instance.restaurant
    restaurant.total_reviews -= 1
    if instance.rating:
        restaurant.rating_counts[str(instance.rating)] -= 1

    reviews = RestaurantReview.objects.filter(restaurant=restaurant)
    average_rating = reviews.aggregate(Avg('rating'))['rating__avg']
    restaurant.rating = average_rating
    restaurant.save()

"""
"""

@receiver(post_save, sender=DelivererReview)
def update_deliverer_review_save(sender, instance, created, **kwargs):
    deliverer = instance.deliverer
    if created:
        deliverer.total_reviews += 1
    if instance.rating:
        deliverer.rating_counts[str(instance.rating)] += 1

    reviews = DelivererReview.objects.filter(deliverer=deliverer)
    average_rating = reviews.aggregate(Avg('rating'))['rating__avg']
    deliverer.rating = average_rating
    deliverer.save()

@receiver(post_delete, sender=DelivererReview)
def update_deliverer_review_delete(sender, instance, **kwargs):
    deliverer = instance.deliverer
    deliverer.total_reviews -= 1
    if instance.rating:
        deliverer.rating_counts[str(instance.rating)] -= 1

    reviews = DelivererReview.objects.filter(deliverer=deliverer)
    average_rating = reviews.aggregate(Avg('rating'))['rating__avg']
    deliverer.rating = average_rating
    deliverer.save()

