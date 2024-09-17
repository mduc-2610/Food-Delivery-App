import os
from django.utils import timezone
from django.db import models


def menu_delivery_image_upload_path(instance, filename):
    restaurant = instance.restaurant
    now = timezone.now()
    return os.path.join(
        'restaurant',
        'menu_delivery',
        now.strftime("%Y/%m/%d"), 
        str(restaurant.id), 
        filename,
    )

class MenuDelivery(models.Model):
    restaurant = models.OneToOneField('restaurant.Restaurant', on_delete=models.CASCADE, related_name='menu_delivery')
    menu_image = models.ImageField(upload_to=menu_delivery_image_upload_path)
    
    def __str__(self):
        return f"Menu Delivery"