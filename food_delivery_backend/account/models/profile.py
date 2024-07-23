import uuid
from django.db import models

class Profile(models.Model):
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="profile", db_index=True)
    name = models.CharField(max_length=155, blank=True, null=True)
    GENDER_CHOICES = (
        ("MALE", "male"),
        ("FEMALE", "female")
    )
    gender = models.CharField(max_length=7, choices=GENDER_CHOICES, blank=True, null=True)
    date_of_birth = models.DateTimeField(blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.name and self.user:
            self.name = str(self.user.id)[:8]  
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name}"
