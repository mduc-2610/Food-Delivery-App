from django.db import models

class ResidencyInfo(models.Model):
    deliverer = models.OneToOneField("deliverer.Deliverer", on_delete=models.CASCADE, related_name="residency_info", null=True)
    is_same_as_ci = models.BooleanField(default=False)
    city = models.CharField(max_length=255, blank=True, null=True)
    district = models.CharField(max_length=255, blank=True, null=True)
    ward = models.CharField(max_length=255, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    tax_code = models.CharField(max_length=30, blank=True, null=True)
    email = models.EmailField()

    def save(self, *args, **kwargs):
        if hasattr(self, 'deliverer') and self.is_same_as_ci:
            self.city = self.deliverer.basic_info.city
            self.district = self.deliverer.basic_info.district
            self.ward = self.deliverer.basic_info.ward
            self.address = self.deliverer.basic_info.address
        super().save(*args, **kwargs)

    def __str__(self):
        return f" Residency Info"