import os
from django.utils import timezone
from django.db import models

def detail_info_image_upload_path(instance, filename):
    restaurant = instance.restaurant
    now = timezone.now()
    return os.path.join(
        'restaurant',
        'detail_info',
        now.strftime("%Y/%m/%d"), 
        str(restaurant.id), 
        filename,
    )


class DetailInfo(models.Model):
    restaurant = models.OneToOneField('restaurant.Restaurant', on_delete=models.CASCADE, related_name='detail_info', null=True)
    keywords = models.CharField(max_length=255)
    description = models.TextField()
    avatar_image = models.ImageField(upload_to=detail_info_image_upload_path)
    cover_image = models.ImageField(upload_to=detail_info_image_upload_path)
    facade_image = models.ImageField(upload_to=detail_info_image_upload_path)
    restaurant_type = models.CharField(max_length=255)
    cuisine = models.CharField(max_length=255)  
    specialty_dishes = models.CharField(max_length=255)  
    serving_times = models.CharField(max_length=255)  
    target_audience = models.CharField(max_length=255)  
    purpose = models.CharField(max_length=255)  
    
    def __str__(self):
        return f" - Details"
    
