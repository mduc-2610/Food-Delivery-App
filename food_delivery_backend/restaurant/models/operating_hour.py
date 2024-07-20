from django.db import models

class OperatingHour(models.Model):
    detail_info = models.ForeignKey("restaurant.DetailInfo", on_delete=models.CASCADE, related_name='operating_hours')
    day_of_week = models.CharField(max_length=20)  
    open_time = models.TimeField()
    close_time = models.TimeField()
    
    def __str__(self):
        return f"{self.detail_info} - {self.day_of_week}"