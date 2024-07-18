from django.db import models

class DriverLicense(models.Model):
    license_front = models.ImageField(upload_to='licenses/')
    license_back = models.ImageField(upload_to='licenses/')
    vehicle_type = models.CharField(max_length=50)
    license_plate = models.CharField(max_length=20)
    registration_certificate = models.ImageField(upload_to='registrations/')
    
    def __str__(self):
        return self.license_plate