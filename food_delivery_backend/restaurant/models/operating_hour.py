from django.db import models

class OperatingHour(models.Model):
    detail_information = models.ForeignKey("restaurant.DetailInformation", on_delete=models.CASCADE, related_name='operating_hours')
    day_of_week = models.CharField(max_length=20)  
    open_time = models.TimeField()
    close_time = models.TimeField()
    
    def __str__(self):
        return f"{self.detail_information} - {self.day_of_week}"