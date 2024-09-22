from django.db import models
from utils.objects import Point, Distance

class BasicInfo(models.Model):
    restaurant = models.OneToOneField("restaurant.Restaurant", on_delete=models.CASCADE, related_name='basic_info')
    name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=15)
    city = models.CharField(max_length=255)
    district = models.CharField(max_length=255)
    street_address = models.CharField(max_length=255)
    latitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    longitude = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)

    def get_distance_from_user(self, location):
        if self.latitude and self.longitude and location.latitude and location.longitude:
            return Distance.haversine(
                Point(self.latitude, self.longitude),
                Point(location.latitude, location.longitude)
            )
        return None
    
    def __str__(self):
        return f"{self.name} {self.phone_number} {self.city}"