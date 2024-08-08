import uuid
from django.db import models

class DirectRoom(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    user1 = models.ForeignKey("account.User", related_name='user2_rooms', on_delete=models.CASCADE)
    user2 = models.ForeignKey("account.User", related_name='user1_rooms', on_delete=models.CASCADE)

    def save(self, *args, **kwargs):
        if not self.name:
            if hasattr(self.user1, 'profile') and hasattr(self.user2, 'profile'):
                self.name = f"{self.user1.profile.name} - {self.user2.profile.name}"
            else:
                self.name = f"{self.user2.phone_number}"
        super().save(*args, **kwargs)

    def __str__(self):
        return f"DirectRoom: {self.name}"
    

class GroupRoom(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    members = models.ManyToManyField("account.User", related_name="groups")

    def __str__(self):
        return f"GroupRoom: {self.name} with {self.members.count()} members"

