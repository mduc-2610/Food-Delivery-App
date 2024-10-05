from django.db import models

class UserRestaurantPromotion(models.Model):
    user = models.ForeignKey('account.User', related_name="user_used", on_delete=models.CASCADE)
    promotion = models.ForeignKey('order.RestaurantPromotion', related_name="user_used", on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'promotion')
        indexes = [
            models.Index(fields=['user', 'promotion'])
        ]

    def __str__(self):
        return f'{self.user} - {self.promotion}'
    

class OrderRestaurantPromotion(models.Model):
    order = models.ForeignKey('order.Order', related_name="order_used", on_delete=models.CASCADE)
    promotion = models.ForeignKey('order.RestaurantPromotion', related_name="order_used", on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('order', 'promotion')
        indexes = [
            models.Index(fields=['order', 'promotion'])
        ]

    def __str__(self):
        return f'{self.order} - {self.promotion}'