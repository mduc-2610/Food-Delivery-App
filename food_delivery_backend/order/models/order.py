import uuid
import decimal
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from order.models import RestaurantCart

class Order(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    cart = models.OneToOneField("order.RestaurantCart", related_name="order", on_delete=models.CASCADE)
    # delivery_address = models.ForeignKey("account.Location", related_name="orders", on_delete=models.SET_NULL, null=True)
    payment_method = models.CharField(max_length=50)
    promotion = models.ForeignKey("order.Promotion", null=True, blank=True, on_delete=models.SET_NULL)
    # delivery_fee = models.DecimalField(max_digits=9, decimal_places=2, default=0.00)
    discount = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)
    STATUS_CHOICES = [
        ("ACTIVE", "Active"),
        ("CANCELLED", "Cancelled"),
        ("COMPLETED", "Completed"),
        ("PENDING", "Pending")
    ]
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="PENDING")
    rating = models.PositiveSmallIntegerField(default=0)

    def total(self):
        return float(self.cart.total_price) + float(self.delivery_fee()) - float(self.discount)
    
    def delivery_address(self):
        user = self.cart.user  
        selected_location = user.locations.filter(is_selected=True).first()
        return selected_location

    def delivery_fee(self):
        delivery_address = self.delivery_address()
        if not self.cart or not delivery_address:
            return decimal.Decimal('0.00')

        restaurant_lat = float(self.cart.restaurant.basic_info.latitude)
        restaurant_long = float(self.cart.restaurant.basic_info.longitude)
        delivery_lat = float(delivery_address.latitude)
        delivery_long = float(delivery_address.longitude)
        
        from utils.function import calculate_distance
        distance = calculate_distance(restaurant_lat, restaurant_long, delivery_lat, delivery_long)

        base_fee = 2.00  
        fee_per_km = 0.50  

        delivery_fee = base_fee + (fee_per_km * distance)
        return decimal.Decimal(delivery_fee).quantize(decimal.Decimal('0.00'))

    # def save(self, *args, **kwargs):
    #     self.delivery_fee = self.calculate_delivery_fee()
    #     super().save(*args, **kwargs)
    
    def __str__(self):
        return f"Order for {self.cart} with total {self.total()}"
