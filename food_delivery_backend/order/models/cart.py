import uuid
from django.db import models
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver

class RestaurantCart(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", related_name='restaurant_carts', on_delete=models.CASCADE, null=True)
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name="user_Carts", on_delete=models.CASCADE, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_empty = models.BooleanField(default=True)
    total_items = models.IntegerField(default=0)
    total_price = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    
    def is_created_order(self):
        return hasattr(self, 'order')
    
    def is_created_delivery(self):
        return hasattr(self, 'order') and hasattr(self.order, 'delivery')

    class Meta:
        ordering = ('-created_at',)

    def __str__(self):
        return f"Restaurant Cart of {self.user} created on {self.created_at}"

class RestaurantCartDish(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    cart = models.ForeignKey("order.RestaurantCart", related_name='dishes', on_delete=models.CASCADE)
    dish = models.ForeignKey("food.Dish", on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)
    price = models.DecimalField(max_digits=6, decimal_places=2)
    discount_price = models.DecimalField(max_digits=6, decimal_places=2, blank=True, null=True)
    options = models.ManyToManyField("food.DishOptionItem", through="order.ChosenDishOption", related_name='in_dishes')
    note = models.TextField(blank=True, null=True)


    class Meta: 
        indexes = [
            models.Index(fields=['cart', 'dish']),
        ]

    def total_price(self):
        base_price = self.discount_price if self.discount_price else self.price
        additional_options_total = sum(
            option_item.price if hasattr(option_item, 'price') else 0 for option_item in self.chosen_options.all()
        )
        return self.quantity * (base_price + additional_options_total)

    def save(self, *args, **kwargs):
        self.price = self.dish.original_price
        self.discount_price = self.dish.discount_price if self.dish.discount_price else self.dish.original_price
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.quantity} of {self.dish.name}"

class ChosenDishOption(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    restaurant_cart_dish = models.ForeignKey("order.RestaurantCartDish", related_name='chosen_options', on_delete=models.CASCADE)
    option_item = models.ForeignKey("food.DishOptionItem", related_name='chosen_in_dishes', on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.option_item.name} chosen for {self.restaurant_cart_dish.dish.name}"

@receiver(post_save, sender=RestaurantCartDish)
def update_cart_totals_on_save(sender, instance, **kwargs):
    restaurant_cart = instance.cart
    restaurant_cart.total_items = sum(dish.quantity for dish in restaurant_cart.dishes.all())
    restaurant_cart.total_price = sum(dish.total_price() for dish in restaurant_cart.dishes.all())
    restaurant_cart.save()

@receiver(post_delete, sender=RestaurantCartDish)
def update_cart_totals_on_delete(sender, instance, **kwargs):
    restaurant_cart = instance.cart
    restaurant_cart.total_items = sum(dish.quantity for dish in restaurant_cart.dishes.all())
    restaurant_cart.total_price = sum(dish.total_price() for dish in restaurant_cart.dishes.all())
    restaurant_cart.save()
