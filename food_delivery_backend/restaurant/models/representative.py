from django.db import models

class Representative(models.Model):
    restaurant = models.OneToOneField('restaurant.Restaurant', on_delete=models.CASCADE, related_name='representative')
    registration_type = models.CharField(max_length=255, choices=[('Cá nhân', 'Cá nhân'), ('Công ty/Chuỗi', 'Công ty/Chuỗi')])
    full_name = models.CharField(max_length=255)
    email = models.EmailField()
    phone_number = models.CharField(max_length=15)
    other_phone_number = models.CharField(max_length=15, blank=True, null=True)
    id_front_image = models.ImageField(upload_to='id_images/')
    id_back_image = models.ImageField(upload_to='id_images/')
    business_registration_image = models.ImageField(upload_to='business_images/', blank=True, null=True)
    
    def __str__(self):
        return self.full_name
