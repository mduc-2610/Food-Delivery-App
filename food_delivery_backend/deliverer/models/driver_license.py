import os
from django.utils import timezone
from django.db import models


def upload_path(instance, filename, media_type):
    deliverer = instance.deliverer
    now = timezone.now()
    return os.path.join(
        'deliverer',
        media_type, 
        now.strftime("%Y/%m/%d"), 
        str(deliverer.id), 
        filename,
    )

def driver_license_image_upload_path(instance, filename):
    return upload_path(instance, filename, 'driver_license')

def registration_certificate_image_upload_path(instance, filename):
    return upload_path(instance, filename, 'motorcycle_registration_certificate')

class DriverLicense(models.Model):
    deliverer = models.OneToOneField("deliverer.Deliverer", on_delete=models.CASCADE, related_name="driver_license")
    driver_license_front = models.ImageField(upload_to=driver_license_image_upload_path, max_length=400)
    driver_license_back = models.ImageField(upload_to=driver_license_image_upload_path, max_length=400)
    motorcycle_registration_certificate_front = models.ImageField(upload_to=registration_certificate_image_upload_path, max_length=400)
    motorcycle_registration_certificate_back = models.ImageField(upload_to=registration_certificate_image_upload_path, max_length=400)
    vehicle_type = models.CharField(max_length=50)
    license_plate = models.CharField(max_length=20)
    
    def __str__(self):
        return self.license_plate