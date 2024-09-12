import uuid
from datetime import timedelta
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils import timezone
from django.db import transaction
from django.db.models import F

from deliverer.models import Deliverer

from utils.objects import Point, Distance
from utils.function import calculate_expired_at

class Delivery(models.Model):
    class Meta:
        ordering = ['-created_at']

    STATUS_CHOICES = [
        ('FINDING_DRIVER', 'Finding Driver'),
        ('ON_THE_WAY', 'On the Way'),
        ('DELIVERED', 'Delivered'),
        ('CANCELLED', 'Cancelled'),
        ('EXPIRED', 'Expired'),
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    order = models.OneToOneField("order.Order", on_delete=models.CASCADE, related_name='delivery', null=True, blank=True)
    deliverer = models.ForeignKey('deliverer.Deliverer', on_delete=models.CASCADE, related_name='deliveries', null=True, blank=True)
    restaurant = models.ForeignKey('restaurant.Restaurant', on_delete=models.CASCADE, related_name='deliveries', null=True, blank=True)
    user = models.ForeignKey('account.User', on_delete=models.CASCADE, related_name='deliveries', null=True, blank=True)
    pickup_location = models.CharField(max_length=255)
    pickup_latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    pickup_longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    dropoff_location = models.CharField(max_length=255)
    dropoff_latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    dropoff_longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='FINDING_DRIVER')
    estimated_delivery_time = models.DateTimeField(blank=True, null=True)
    actual_delivery_time = models.DateTimeField(blank=True, null=True)
    started_at = models.DateTimeField(blank=True, null=True)
    finished_at = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    expired_at = models.DateTimeField(blank=True, null=True)

    def calculate_estimated_delivery_time(self):
        if not (self.pickup_latitude and self.pickup_longitude and self.dropoff_latitude and self.dropoff_longitude):
            return None

        pickup_coordinate = Point(
            self.pickup_longitude,
            self.pickup_latitude,
        )
        dropoff_coordinate = Point(
            self.dropoff_longitude,
            self.dropoff_latitude,
        )

        distance = Distance.haversine(
            pickup_coordinate,
            dropoff_coordinate
        )
        average_speed_mps = 11.11 
        distance_km = distance / 1000.0
        estimated_time_seconds = distance / average_speed_mps
        estimated_time = timedelta(seconds=estimated_time_seconds)
        return timezone.now() + estimated_time
        
    def save(self, *args, **kwargs):
        self.expired_at = calculate_expired_at('1h')
        if self.estimated_delivery_time is None:
            self.estimated_delivery_time = self.calculate_estimated_delivery_time()
        if self.status != 'FINDING_DRIVER' and self._state.adding:
            self.started_at = timezone.now()
        if self.status == 'DELIVERED':
            self.finished_at = timezone.now()
            self.order.status = 'COMPLETED'
            self.order.save()
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Delivery {self.id} for Order {self.order.id}"

class DeliveryRequest(models.Model):
    class Meta:
        ordering = ('-created_at',)

    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('ACCEPTED', 'Accepted'),
        ('DECLINED', 'Declined'),
        ('EXPIRED', 'Expired'),
        ('CANCELLED', 'Cancelled'),
        ('COMPLETED', 'Completed'),
    ]
    
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    deliverer = models.ForeignKey('deliverer.Deliverer', on_delete=models.CASCADE, related_name='requests')
    delivery = models.ForeignKey('order.Delivery', on_delete=models.CASCADE, related_name='requests')
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='PENDING')
    expired_at = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    updated_at = models.DateTimeField(auto_now=True, blank=True, null=True)
    responded_at = models.DateTimeField(null=True, blank=True)
    
    def save(self, *args, **kwargs):
        self.expired_at = calculate_expired_at('10m')
        super().save(*args, **kwargs)

    def _update_status(self, new_status):
        old_status = self.status
        self.status = new_status
        self.responded_at = timezone.now()
        self.save()

        if new_status == 'ACCEPTED':
            self._handle_accepted()
        elif new_status in ['DECLINED', 'EXPIRED']:
            self._handle_declined_or_expired()
        elif new_status == 'CANCELLED':
            self._handle_cancelled()
        elif new_status == 'COMPLETED':
            self._handle_complete()

        if new_status in ['ACCEPTED', 'DECLINED', 'EXPIRED'] and old_status == 'PENDING':
            self.deliverer.total_requests = F('total_requests') + 1
            self.deliverer.save(update_fields=['total_requests'])

    def _handle_accepted(self):
        self.delivery.deliverer = self.deliverer
        self.delivery.status = 'ON_THE_WAY'
        self.delivery.started_at = timezone.now()
        self.delivery.save()

        self.deliverer.is_occupied = True
        self.deliverer.save(update_fields=['is_occupied'])

        self._reassign_nearest_deliverers(action='accept')

    def _handle_declined_or_expired(self):
        self._reassign_nearest_deliverers(action='decline')

    def _handle_cancelled(self):
        self.delivery.deliverer = None
        self.delivery.status = 'FINDING_DRIVER'
        self.delivery.save()

    def _handle_complete(self):
        self.deliverer.is_occupied = False
        self.deliverer.is_active = True
        self.deliverer.accepted_requests = F('accepted_requests') + 1
        self.deliverer.save(update_fields=['is_occupied', 'is_active', 'accepted_requests'])
        
        self.delivery.status = 'DELIVERED'
        self.delivery.save()

    def accept(self):
        self._update_status('ACCEPTED')

    def decline(self):
        self._update_status('DECLINED')

    def expire(self):
        self._update_status('EXPIRED')

    def cancel(self):
        self._update_status('CANCELLED')
    
    def complete(self):
        self._update_status('COMPLETED')

    def _reassign_nearest_deliverers(self, action='accept'):
        if action == 'decline':
            available_deliverers = Deliverer.objects.filter(is_active=True, is_occupied=False).exclude(id=self.deliverer.id)
            nearest_deliverer = self._find_nearest_deliverer(self.delivery, available_deliverers)
            if nearest_deliverer:
                DeliveryRequest.objects.create(
                    deliverer=nearest_deliverer,
                    delivery=self.delivery
                )
        else:
            available_deliverers = Deliverer.objects.filter(is_active=True, is_occupied=False)
            for _request in self.deliverer.requests.exclude(id=self.id):
                nearest_deliverer = self._find_nearest_deliverer(_request.delivery, available_deliverers)
                if nearest_deliverer:
                    _request.deliverer = nearest_deliverer
                    _request.save()

    @staticmethod
    def _find_nearest_deliverer(delivery, deliverers):
        restaurant_point = Point(delivery.pickup_latitude, delivery.pickup_longitude)
        nearest_deliverer = None
        min_distance = float('inf')

        for deliverer in deliverers:
            deliverer_point = Point(deliverer.current_latitude, deliverer.current_longitude)
            distance = Distance.haversine(restaurant_point, deliverer_point)
            if distance < min_distance:
                min_distance = distance
                nearest_deliverer = deliverer

        return nearest_deliverer
        