from django.db import models


class PaymentInfo(models.Model):
    restaurant = models.OneToOneField('restaurant.Restaurant', on_delete=models.CASCADE, related_name='payment_info', null=True)
    email = models.EmailField()
    phone_number = models.CharField(max_length=15)
    citizen_identification = models.CharField(max_length=20)
    account_name = models.CharField(max_length=255)
    account_number = models.CharField(max_length=30)
    bank = models.CharField(max_length=255,)
    city = models.CharField(max_length=255,)
    branch = models.CharField(max_length=255,)

    def __str__(self):
        return f"Payment {self.account_name} ({self.email})"
