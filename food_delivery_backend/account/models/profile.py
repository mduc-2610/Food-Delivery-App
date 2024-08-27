import os
import random
from django.conf import settings
from django.db import models

def user_avatar_upload_path(instance, filename):
    return os.path.join(
        'avatar',
        'user',
        str(instance.id),
        filename,
    )

class Profile(models.Model):
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="profile", db_index=True)
    avatar = models.ImageField(upload_to=user_avatar_upload_path, blank=True, null=True)
    name = models.CharField(max_length=155, blank=True, null=True)
    GENDER_CHOICES = (
        ("MALE", "male"),
        ("FEMALE", "female")
    )
    gender = models.CharField(max_length=7, choices=GENDER_CHOICES, blank=True, null=True)
    date_of_birth = models.DateTimeField(blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.name and self.user:
            self.name = str(self.user.id).split('-')[0]
        
        if not self.avatar:
            user_avatar_folder_path = os.path.join(settings.MEDIA_ROOT, "avatar/user")

            if not os.path.exists(user_avatar_folder_path):
                print(f"User avatar folder not found: {user_avatar_folder_path}")

            else:
                avatar_path_list = os.listdir(user_avatar_folder_path)
                if avatar_path_list:
                    self.avatar = f"avatar/user/{random.choice(avatar_path_list)}"
        
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name}"
