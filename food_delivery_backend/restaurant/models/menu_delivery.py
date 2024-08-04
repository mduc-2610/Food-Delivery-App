from django.db import models

class MenuDelivery(models.Model):
    restaurant = models.OneToOneField('restaurant.Restaurant', on_delete=models.CASCADE, related_name='menu_delivery')
    menu_image = models.ImageField(upload_to='menu_images/')
    
    def __str__(self):
        return f"Menu Delivery"