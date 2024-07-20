from django.db import models

class MenuDelivery(models.Model):
    menu_image = models.ImageField(upload_to='menu_images/')
    
    def __str__(self):
        return f"Menu Delivery"