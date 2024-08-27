import os
import uuid
import random
from django.db import models
from django.conf import settings

def default_rating_counts(): 
    return {
        "1": 0,
        "2": 0,
        "3": 0,
        "4": 0,
        "5": 0
    }

def deliverer_avatar_upload_path(instance, filename):
    return os.path.join(
        'avatar',
        'deliverer',
        str(instance.id), 
        filename,
    )

class Deliverer(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="deliverer")
    rating = models.DecimalField(max_digits=3, decimal_places=1, default=0, blank=True, null=True)
    total_reviews = models.IntegerField(default=0, blank=True, null=True)
    rating_counts = models.JSONField(default=default_rating_counts, blank=True, null=True)
    avatar = models.ImageField(upload_to=deliverer_avatar_upload_path, blank=True, null=True)

    def __getitem__(self, attr):
        if hasattr(self, attr):
            return getattr(self, attr)
        else:
            raise AttributeError(f"{attr} is not a valid attribute")

    def save(self, *args, **kwargs):
        if not self.avatar:
            deliverer_avatar_folder_path = os.path.join(settings.MEDIA_ROOT, "avatar/deliverer")

            if not os.path.exists(deliverer_avatar_folder_path):
                print(f"Deliverer avatar folder not found: {deliverer_avatar_folder_path}")

            else:
                avatar_path_list = os.listdir(deliverer_avatar_folder_path)
                if avatar_path_list:
                    self.avatar = f"avatar/deliverer/{random.choice(avatar_path_list)}"
        super().save(*args, **kwargs)
    def __str__(self):
        return f"{self.id}"
