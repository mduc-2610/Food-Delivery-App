from django.db import models

class ResidencyInfo(models.Model):
    is_same_as_ci = models.BooleanField(default=False)
    city = models.CharField(max_length=255, blank=True)
    district = models.CharField(max_length=255, blank=True)
    ward = models.CharField(max_length=255, blank=True)
    address = models.CharField(max_length=255, blank=True)
    tax_code = models.CharField(max_length=30, blank=True, null=True)
    email = models.EmailField()

    def save(self, *args, **kwargs):
        # if self.is_same_as_ci:
            # self.city = self.residency_info.basic_info.city
            # self.district = self.residency_info.basic_info.district
            # self.ward = self.residency_info.basic_info.ward
            # self.address = self.residency_info.basic_info.address
        super().save(*args, **kwargs)

    def __str__(self):
        return f" Residency Info"