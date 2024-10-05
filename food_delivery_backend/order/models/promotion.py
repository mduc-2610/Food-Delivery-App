import uuid 
from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from django.contrib.auth.models import AnonymousUser

from order.models.order import Order
from order.models.used_promotion import (
    UserRestaurantPromotion, 
    OrderRestaurantPromotion,
)

class BasePromotion(models.Model):
    PROMO_TYPES = [
        ('SHIPPING', 'Shipping'),
        ('ORDER', 'Order'),
        # ('ACTIVITY', 'Activity'),
    ]
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    name = models.CharField(max_length=100)
    code = models.CharField(max_length=50, blank=True, null=True, unique=True)
    promo_type = models.CharField(max_length=20, choices=PROMO_TYPES)
    discount_percentage = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    discount_amount = models.DecimalField(max_digits=6, decimal_places=2, null=True, blank=True)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    applicable_price = models.DecimalField(max_digits=8, decimal_places=2, null=True, blank=True)
    description = models.TextField(blank=True, null=True)
    terms_and_conditions = models.TextField(blank=True, null=True)
    is_disabled = models.BooleanField(default=False)

    def is_available(self, request=None):
        if not request \
            or not hasattr(request, 'user') \
            or isinstance(request.user, AnonymousUser): return False
        need_query = request.query_params.get('need_query')
        if not need_query: return False
        now = timezone.now()
        return not UserRestaurantPromotion.objects.filter(user=request.user, promotion=self).exists() \
            and not self.is_disabled \
            and self.start_date <= now <= self.end_date
    
    def is_chosen(self, request=None):
        if not request: return False
        query_params = request.query_params
        order_id = request.query_params.get('order')
        order = Order.objects.get(id=order_id) if order_id else None
        if not order: return False
        return OrderRestaurantPromotion.objects.filter(order=order, promotion=self).exists()

    class Meta:
        abstract = True
        ordering = ['-start_date', '-end_date']

class RestaurantPromotion(BasePromotion):
    restaurant = models.ForeignKey("restaurant.Restaurant", on_delete=models.CASCADE, related_name="promotions", blank=True, null=True)

    def __str__(self):
        return self.code

# class ActivityPromotion(models.Model):
#     ACTIVITY_TYPES = [
#         ('share_app', 'Share App'),
#         ('invite_friends', 'Invite Friends'),
#         ('complete_purchase', 'Complete Purchase'),
#         ('watch_ads', 'Watch Ads'),
#         ('participate_events', 'Participate in Events'),
#         ('complete_profile', 'Complete Profile'),
#         ('follow_social_media', 'Follow Social Media'),
#         ('take_surveys', 'Take Surveys'),
#         ('achieve_levels', 'Achieve Levels'),
#         ('daily_logins', 'Daily Logins'),
#     ]

#     promotion = models.OneToOneField(Promotion, on_delete=models.CASCADE)
#     activity_type = models.CharField(max_length=50, choices=ACTIVITY_TYPES)

#     def __str__(self):
#         return f"{self.get_activity_type_display()} - {self.promotion.code}"