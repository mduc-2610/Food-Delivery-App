from django.db import models

class BasicInfo(models.Model):
    restaurant = models.OneToOneField("restaurant.Restaurant", on_delete=models.CASCADE, related_name='basic_info')
    name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=15)
    city = models.CharField(max_length=255)
    district = models.CharField(max_length=255)
    street_address = models.CharField(max_length=255)
    latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)

    def __str__(self):
        return f"{self.name} {self.phone_number} {self.city}"