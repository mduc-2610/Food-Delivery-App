import uuid
from django.db import models
from django.utils import timezone

class Delivery(models.Model):
    STATUS_CHOICES = [
        ('FINDING_DRIVER', 'Finding Driver'),
        ('ON_THE_WAY', 'On the Way'),
        ('DELIVERED', 'Delivered'),
        ('CANCELLED', 'Cancelled')
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    order = models.ForeignKey("order.Order", on_delete=models.CASCADE, related_name='deliverers')
    deliverer = models.ForeignKey('deliverer.Deliverer', on_delete=models.CASCADE, related_name='deliveries', null=True, blank=True)
    pickup_location = models.CharField(max_length=255)
    pickup_lat = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    pickup_long = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    dropoff_location = models.CharField(max_length=255)
    dropoff_lat = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    dropoff_long = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='FINDING_DRIVER')
    estimated_delivery_time = models.DateTimeField(blank=True, null=True)
    actual_delivery_time = models.DateTimeField(blank=True, null=True)
    started_at = models.DateTimeField(blank=True, null=True)
    finished_at = models.DateTimeField(blank=True, null=True)

    def save(self, *args, **kwargs):
        if self.status != 'FINDING_DRIVER' and self._state.adding:
            self.started_at = timezone.now()
        if self.status == 'DELIVERED' or self.status == 'CANCELLED':
            self.finished_at = timezone.now()
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Delivery {self.id} for Order {self.order.id}"
