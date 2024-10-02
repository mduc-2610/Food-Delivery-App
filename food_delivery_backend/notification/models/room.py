import uuid
from django.core import exceptions
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver

class DirectRoom(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user1 = models.ForeignKey("account.User", related_name='user2_rooms', on_delete=models.CASCADE)
    user2 = models.ForeignKey("account.User", related_name='user1_rooms', on_delete=models.CASCADE)
    latest_message = models.ForeignKey("notification.DirectMessage", null=True, blank=True, on_delete=models.SET_NULL, related_name='latest_message')
    created_at = models.DateTimeField(auto_now_add=True, blank=True)
    
    class Meta:
        indexes = [
            models.Index(fields=['user1', 'user2']),
        ]
        ordering = ['latest_message__created_at']

    def clean(self):
        if DirectRoom.objects.filter(user1=self.user2, user2=self.user1).exists() \
            or DirectRoom.objects.filter(user1=self.user1, user2=self.user2).exists():
            raise exceptions.ValidationError("A DirectRoom already exists for this user pair.")

    def save(self, *args, **kwargs):
        if self.pk is None:
            self.clean()
        super().save(*args, **kwargs)

    def __str__(self):
        return f"DirectRoom: {self.user1} - {self.user2}"

class GroupRoom(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    members = models.ManyToManyField("account.User", related_name="groups")
    latest_message = models.ForeignKey("notification.GroupMessage", null=True, blank=True, on_delete=models.SET_NULL, related_name='+')

    def __str__(self):
        return f"GroupRoom: {self.name} with {self.members.count()} members"

