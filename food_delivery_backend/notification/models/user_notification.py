import uuid
from django.db import models

class UserNotification(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", on_delete=models.CASCADE, related_name='received_notifications')
    notification = models.ForeignKey("notification.Notification", on_delete=models.CASCADE, related_name="sent_notifications")
    timestamp = models.DateTimeField(auto_now_add=True)
    read_status = models.BooleanField(default=False)
    