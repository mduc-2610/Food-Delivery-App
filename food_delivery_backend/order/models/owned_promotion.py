import uuid
from django.db import models

class OwnedPromotion(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    promotion = models.ForeignKey("order.Promotion", related_name="%(class)s_promotions", on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        abstract = True

    def __str__(self):
        return f"{self.promotion} - {self.timestamp}"

class OrderPromotion(OwnedPromotion):
    order = models.ForeignKey("order.Order", related_name="used_promotions", on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.order} - {self.promotion} - {self.timestamp}"

class RestaurantPromotion(OwnedPromotion):
    restaurant = models.ForeignKey("restaurant.Restaurant", related_name="owned_promotions", on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.restaurant} - {self.promotion} - {self.timestamp}"

class UserPromotion(OwnedPromotion):
    user = models.ForeignKey("account.User", related_name="user_promotions", on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user} - {self.promotion} - {self.timestamp}"
