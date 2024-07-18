from django.db import models

class BasicInfo(models.Model):
    name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=15)
    city = models.CharField(max_length=255)
    district = models.CharField(max_length=255)
    street_address = models.CharField(max_length=255)
    map_location = models.CharField(max_length=255)  

    def __str__(self):
        return f"{self.name} {self.phone_number} {self.city}"