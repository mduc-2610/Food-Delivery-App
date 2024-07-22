from django.db import models

class Profile(models.Model):
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="profile")
    name = models.CharField(max_length=155)
    GENDER_CHOICES = (
        ("MALE", "male"),
        ("FEMALE", "female")
    )
    gender = models.CharField(max_length=7, choices=GENDER_CHOICES, blank=True, null=True)
    date_of_birth = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return f"{self.name}"

class Location(models.Model):
    profile = models.ForeignKey(Profile, on_delete=models.CASCADE, related_name="locations")
    address = models.CharField(max_length=300, blank=True, null=True)
    latitude = models.FloatField(blank=True, null=True)
    longitude = models.FloatField(blank=True, null=True)

    def __str__(self):
        return f"{self.address} ({self.latitude}, {self.longitude})"
