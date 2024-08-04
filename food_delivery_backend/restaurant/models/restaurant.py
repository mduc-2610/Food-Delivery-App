import uuid
from django.db import models

class Restaurant(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name='restaurant')
    
    promotions = models.ManyToManyField('order.Promotion', through="order.RestaurantPromotion", related_name='promotions')
    
    # def name(self):
    #     return self.basic_info.name

    # def description(self):
    #     return self.detail_info.description
    
    def __getitem__(self, attr):
        if hasattr(self, attr):
            return getattr(self, attr)
        else:
            raise AttributeError(f"{attr} is not a valid attribute")

    def __str__(self):
        return f"{self.id}"