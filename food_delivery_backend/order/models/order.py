import uuid
import decimal

from django.db import models
from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver

from order.models import RestaurantCart, Delivery, DeliveryRequest
from review.models import (
    DishReview,
    DelivererReview, 
    RestaurantReview
)
from deliverer.models import Deliverer
from utils.objects import Point, Distance

class Order(models.Model):
    class Meta:
        ordering = ['-created_at']
        
    STATUS_CHOICES = [
        ("ACTIVE", "Active"),
        ("CANCELLED", "Cancelled"),
        ("COMPLETED", "Completed"),
        ("PENDING", "Pending")
    ]
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    cart = models.OneToOneField("order.RestaurantCart", related_name="order", on_delete=models.CASCADE)
    user = models.ForeignKey("account.User", related_name="orders", on_delete=models.CASCADE, blank=True, null=True)
    payment_method = models.CharField(max_length=50)
    promotion = models.ForeignKey("order.Promotion", null=True, blank=True, on_delete=models.SET_NULL)
    discount = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="PENDING")
    rating = models.PositiveSmallIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    updated_at = models.DateTimeField(auto_now=True, blank=True, null=True)        
    is_reviewed = models.BooleanField(default=False, null=True, blank=True)
    is_order_reviewed = models.BooleanField(default=False, null=True, blank=True)
    is_dish_reviewed = models.BooleanField(default=False, null=True, blank=True)
    is_deliverer_reviewed = models.BooleanField(default=False, null=True, blank=True)
    is_restaurant_reviewed = models.BooleanField(default=False, null=True, blank=True)

    # def is_reviewed(self):
    #     return self.is_order_reviewed and self.is_dish_reviewed and self.is_deliverer_reviewed
    
    def total_price(self):
        return self.cart.total_price

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

        restaurant_coordinate = Point(
            float(self.cart.restaurant.basic_info.latitude),
            float(self.cart.restaurant.basic_info.longitude)
        )
        user_coordinate = Point(
            float(delivery_address.latitude),
            float(delivery_address.longitude),

        )
        
        distance = Distance.haversine(
            restaurant_coordinate,
            user_coordinate
        )

        base_fee = 2.00  
        fee_per_km = 0.50  

        delivery_fee = base_fee + (fee_per_km * distance)
        return decimal.Decimal(delivery_fee).quantize(decimal.Decimal('0.00'))
    
    def create_delivery_and_request(self, create_delivery=False):
        restaurant = self.cart.restaurant
        user = self.cart.user
        delivery_address = self.delivery_address()
        self.status = "ACTIVE"
        self.save()

        if not delivery_address:
            return

        delivery, created_delivery = Delivery.objects.get_or_create(
            order=self,
            user=user,
            restaurant=restaurant,
            defaults={
                'pickup_location': restaurant.basic_info.street_address,
                'pickup_latitude': restaurant.basic_info.latitude,
                'pickup_longitude': restaurant.basic_info.longitude,
                'dropoff_location': delivery_address.address,
                'dropoff_latitude': delivery_address.latitude,
                'dropoff_longitude': delivery_address.longitude,
            }
        )
        nearest_deliverer = DeliveryRequest._find_nearest_deliverer(delivery, Deliverer.objects.filter(is_active=True, is_occupied=False))

        if nearest_deliverer:
            delivery_request, created_request = DeliveryRequest.objects.get_or_create(
                deliverer=nearest_deliverer,
                delivery=delivery,
                defaults={
                    'status': 'PENDING'
                }
            )
        print(nearest_deliverer, pretty=True)

        return delivery, nearest_deliverer

    def save(self, *args, **kwargs):
        if hasattr(self, 'cart') and hasattr(self.cart, 'user'):
            self.user = self.cart.user
        # self.cart.is_created_order = True
        super(Order, self).save(*args, **kwargs)

    def __str__(self):
        return f"Order for {self.cart} with total {self.total()}"


# @receiver(post_save, sender='order.Order')
# def broadcast_to_deliverers(sender, instance, **kwargs):
#     if instance.status == 'ACTIVE':
#         create_delivery_and_requests(instance, create_delivery=True)


@receiver(post_save, sender='order.Order')
def broadcast_to_deliverers(sender, instance, **kwargs):
    pass

@receiver(post_save, sender='order.Order')
def check_order_status(sender, instance, **kwargs):
    check_order_ratings(instance)

@receiver(post_save, sender='review.DelivererReview')
def update_deliverer_rated(sender, instance, **kwargs):
    order = instance.order
    check_order_ratings(order)

@receiver(post_save, sender='review.DishReview')
def update_food_rated(sender, instance, **kwargs):
    order = instance.order
    check_order_ratings(order)

@receiver(post_save, sender='review.RestaurantReview')
def update_restaurant_rated(sender, instance, **kwargs):
    order = instance.order
    check_order_ratings(order)

def check_order_ratings(order):
    update_fields = []

    if order.status == "COMPLETED":
        if order.rating > 0 and not order.is_order_reviewed:
            order.is_order_reviewed = True
            update_fields.append('is_order_reviewed')

        if hasattr(order, 'delivery') and not order.is_deliverer_reviewed:
            if DelivererReview.objects.filter(user=order.user, order=order, deliverer=order.delivery.deliverer).exists():
                order.is_deliverer_reviewed = True
                update_fields.append('is_deliverer_reviewed')

        if hasattr(order, 'cart') and  order.cart.restaurant and not order.is_restaurant_reviewed:
            if RestaurantReview.objects.filter(user=order.user, order=order, restaurant=order.cart.restaurant).exists():
                order.is_restaurant_reviewed = True
                update_fields.append('is_restaurant_reviewed')

        cart_dishes = order.cart.dishes.all()
        all_rated = any(
            DishReview.objects.filter(user=order.user, order=order, dish=dish.dish).exists()
            for dish in cart_dishes
        )
        if all_rated and not order.is_dish_reviewed:
            order.is_dish_reviewed = True
            update_fields.append('is_dish_reviewed')
        
        if update_fields:
            order.is_reviewed = order.is_order_reviewed \
                                and order.is_dish_reviewed \
                                and order.is_deliverer_reviewed \
                                and order.is_restaurant_reviewed
            update_fields.append('is_reviewed')
            order.save(update_fields=update_fields)


class OrderCancellation(models.Model):
    order = models.OneToOneField("order.Order", related_name="cancellation", on_delete=models.CASCADE)
    user = models.ForeignKey("account.User", related_name="cancellations", on_delete=models.CASCADE)
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name="cancellations", on_delete=models.CASCADE)
    reason = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    updated_at = models.DateTimeField(auto_now=True, blank=True, null=True)
    is_accepted = models.BooleanField(default=False, blank=True, null=True)

    class Meta: 
        unique_together = ("user", "restaurant")

    def __str__(self):
        return f"Cancellation for {self.order}"
    
@receiver(post_save, sender='order.OrderCancellation')
def update_order_status(sender, instance, **kwargs):
    if instance.is_accepted:
        instance.order.status = 'CANCELLED'
        instance.order.save()