from django.db import models

class Address(models.Model):
    city = models.CharField(max_length=100)
    district = models.CharField(max_length=100)
    ward = models.CharField(max_length=100)
    detail_address = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.detail_address}, {self.ward}, {self.district}, {self.city}"