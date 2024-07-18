import uuid 
from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

class Promotion(models.Model):
    PROMO_TYPES = [
        ('SHIPPING', 'Shipping'),
        ('ORDER', 'Order'),
        ('ACTIVITY', 'Activity'),
    ]
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    code = models.CharField(max_length=50, unique=True)
    description = models.TextField()
    promo_type = models.CharField(max_length=20, choices=PROMO_TYPES)
    discount_percentage = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    discount_amount = models.DecimalField(max_digits=6, decimal_places=2, null=True, blank=True)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    applicable_scope = models.CharField(max_length=255)
    terms_and_conditions = models.TextField()
    active = models.BooleanField(default=True)

    def is_active(self):
        now = timezone.now()
        return self.active and self.start_date <= now <= self.end_date

    def __str__(self):
        return self.code

class ActivityPromotion(models.Model):
    ACTIVITY_TYPES = [
        ('share_app', 'Share App'),
        ('invite_friends', 'Invite Friends'),
        ('complete_purchase', 'Complete Purchase'),
        ('watch_ads', 'Watch Ads'),
        ('participate_events', 'Participate in Events'),
        ('complete_profile', 'Complete Profile'),
        ('follow_social_media', 'Follow Social Media'),
        ('take_surveys', 'Take Surveys'),
        ('achieve_levels', 'Achieve Levels'),
        ('daily_logins', 'Daily Logins'),
    ]

    promotion = models.OneToOneField(Promotion, on_delete=models.CASCADE)
    activity_type = models.CharField(max_length=50, choices=ACTIVITY_TYPES)

    def __str__(self):
        return f"{self.get_activity_type_display()} - {self.promotion.code}"