import uuid
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import User

class Cart(models.Model):
    user = models.OneToOneField("account.User", on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ('-created_at',)

    def __str__(self):
        return f"Cart of {self.user} created on {self.created_at}"

class RestaurantCart(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    cart = models.ForeignKey("order.Cart", related_name='restaurant_carts', on_delete=models.CASCADE)
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name="restaurant", on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_placed_order = models.BooleanField(default=False)
    raw_fee = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)

    class Meta:
        ordering = ('-created_at',)

    def __str__(self):
        return f"Restaurant Cart of {self.cart.user} created on {self.created_at}"

class RestaurantCartDish(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    cart = models.ForeignKey("order.RestaurantCart", related_name='dishes', on_delete=models.CASCADE)
    dish = models.ForeignKey("food.Dish", on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    price = models.DecimalField(max_digits=6, decimal_places=2)

    def __str__(self):
        return f"{self.quantity} of {self.dish.name}"

@receiver(post_save, sender=RestaurantCartDish)
def update_raw_fee(sender, instance, **kwargs):
    restaurant_cart = instance.cart
    restaurant_cart.raw_fee += instance.quantity * instance.price
    restaurant_cart.save()
