import os
from django.utils import timezone
from django.db import models

def upload_path(instance, filename, folder):
    restaurant = instance.restaurant
    now = timezone.now()
    return os.path.join(
        'restaurant',
        folder,
        now.strftime("%Y/%m/%d"), 
        str(restaurant.id), 
        filename,
    )

def citizen_identification_image_upload_path(instance, filename):
    return upload_path(instance, filename, 'representative_info')

def business_registration_image_upload_path(instance, filename):
    return upload_path(instance, filename, 'business_registration')

class RepresentativeInfo(models.Model):
    REGISTRATION_CHOICES = (
        ('INDIVIDUAL', 'Individual'),
        ('RESTAURANT_CHAIN', 'Restaurant Chain')
    )
    restaurant = models.OneToOneField('restaurant.Restaurant', on_delete=models.CASCADE, related_name='representative_info')
    registration_type = models.CharField(max_length=255, choices=REGISTRATION_CHOICES)
    full_name = models.CharField(max_length=255)
    email = models.EmailField()
    phone_number = models.CharField(max_length=15)
    other_phone_number = models.CharField(max_length=15, blank=True, null=True)
    tax_code = models.CharField(max_length=20, default="")
    citizen_identification = models.CharField(max_length=20, default="")
    citizen_identification_front = models.ImageField(upload_to=citizen_identification_image_upload_path)
    citizen_identification_back = models.ImageField(upload_to=citizen_identification_image_upload_path)
    business_registration_image = models.ImageField(upload_to=business_registration_image_upload_path, blank=True, null=True)
    
    def __str__(self):
        return self.full_name
