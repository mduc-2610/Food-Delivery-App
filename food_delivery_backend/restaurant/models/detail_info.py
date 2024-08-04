from django.db import models

class DetailInfo(models.Model):
    restaurant = models.OneToOneField('restaurant.Restaurant', on_delete=models.CASCADE, related_name='detail_info', null=True)
    keywords = models.CharField(max_length=255)
    description = models.TextField()
    avatar_image = models.ImageField(upload_to='restaurant_images/')
    cover_image = models.ImageField(upload_to='restaurant_images/')
    facade_image = models.ImageField(upload_to='restaurant_images/')
    restaurant_type = models.CharField(max_length=255)
    cuisine = models.CharField(max_length=255)  
    specialty_dishes = models.CharField(max_length=255)  
    serving_times = models.CharField(max_length=255)  
    target_audience = models.CharField(max_length=255)  
    restaurant_category = models.CharField(max_length=255)  
    purpose = models.CharField(max_length=255)  
    
    def __str__(self):
        return f" - Details"