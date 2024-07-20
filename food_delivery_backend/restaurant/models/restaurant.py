import uuid
from django.db import models

class Restaurant(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name='restaurant')
    basic_info = models.OneToOneField("restaurant.BasicInfo", on_delete=models.CASCADE, related_name='basic_info')
    representative = models.OneToOneField('restaurant.Representative', on_delete=models.CASCADE, related_name='representative')
    detail_information = models.OneToOneField('restaurant.DetailInformation', on_delete=models.CASCADE, related_name='detail_information')
    menu_delivery = models.OneToOneField('restaurant.MenuDelivery', on_delete=models.CASCADE, related_name='menu_delivery')
    
    promotions = models.ManyToManyField('order.RestaurantPromotion', related_name='promotions')
    
    def name(self):
        return self.basic_info.name

    def description(self):
        return self.detail_information.description

    def __str__(self):
        return f"{self.name()}"