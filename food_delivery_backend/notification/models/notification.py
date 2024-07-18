import uuid
from django.db import models
from django.contrib.auth.models import User

class Notification(models.Model):
    NOTIFICATION_TYPES = (
        ('DISCOUNT', 'Discount'),
        ('ORDER', 'Order'),
        ('ACCOUNT', 'Account'),
    )
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    notification_type = models.CharField(max_length=20, choices=NOTIFICATION_TYPES)
    title = models.CharField(max_length=100)
    description = models.TextField()

    def __str__(self):
        return self.title
