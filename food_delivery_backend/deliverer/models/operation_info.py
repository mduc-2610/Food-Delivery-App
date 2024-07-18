from django.db import models

class OperationInfo(models.Model):
    city = models.CharField(max_length=100)
    operation_type = models.CharField(max_length=50, choices=[('HUB', 'Tài xế HUB'), ('PART_TIME', 'Tài xế Part-time')])
    operational_area = models.CharField(max_length=255)
    operational_time = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.city}, {self.operation_type}"