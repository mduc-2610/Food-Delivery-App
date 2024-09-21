import uuid
from django.db import models

class OperatingHour(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    detail_info = models.ForeignKey("restaurant.DetailInfo", on_delete=models.CASCADE, related_name='operating_hours_2')
    day_of_week = models.CharField(max_length=20)  
    open_time = models.TimeField()
    close_time = models.TimeField()
    
    def __str__(self):
        return f"{self.detail_info} - {self.day_of_week}"