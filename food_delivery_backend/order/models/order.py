import uuid
import decimal
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from order.models import RestaurantCart

class Order(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    cart = models.OneToOneField("order.RestaurantCart", related_name="order", on_delete=models.CASCADE)
    delivery_address = models.ForeignKey("account.Location", related_name="orders", on_delete=models.SET_NULL, null=True)
    payment_method = models.CharField(max_length=50)
    promotion = models.ForeignKey("order.Promotion", null=True, blank=True, on_delete=models.SET_NULL)
    delivery_fee = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)
    discount = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)
    STATUS_CHOICES = [
        ("ACTIVE", "Active"),
        ("CANCELLED", "Cancelled"),
        ("COMPLETED", "Completed"),
        ("PENDING", "Pending")
    ]
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="PENDING")
    rating = models.PositiveSmallIntegerField(default=0)

    def raw_fee(self):
        return self.cart.raw_fee()

    def total(self):
        return float(self.raw_fee()) + float(self.delivery_fee) - float(self.discount)
    
    def __str__(self):
        return f"Order for {self.cart} with total {self.total()}"
