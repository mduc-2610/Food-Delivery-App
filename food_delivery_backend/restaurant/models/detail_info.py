import os
import json
from django.utils import timezone
from django.db import models
from django.core.exceptions import ValidationError

def detail_info_image_upload_path(instance, filename):
    restaurant = instance.restaurant
    now = timezone.now()
    return os.path.join(
        'restaurant',
        'detail_info',
        now.strftime("%Y/%m/%d"), 
        str(restaurant.id), 
        filename,
    )

def validate_operating_hours(value):
    try:
        hours = json.loads(value)
        days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
        for day in days:
            if day not in hours:
                raise ValidationError(f"Missing operating hours for {day}")
            day_hours = hours[day]
            if not isinstance(day_hours, list):
                raise ValidationError(f"Invalid format for {day}")
            for period in day_hours:
                if 'open' not in period or 'close' not in period:
                    raise ValidationError(f"Invalid time format for {day}")
    except json.JSONDecodeError:
        raise ValidationError("Invalid JSON format")

def default_operating_hours():
    return {
        "Monday": [{"open": "09:00", "close": "17:00"}],
        "Tuesday": [{"open": "09:00", "close": "17:00"}],
        "Wednesday": [{"open": "09:00", "close": "17:00"}],
        "Thursday": [{"open": "09:00", "close": "17:00"}],
        "Friday": [{"open": "09:00", "close": "17:00"}],
        "Saturday": [],
        "Sunday": []
    }

class DetailInfo(models.Model):
    restaurant = models.OneToOneField('restaurant.Restaurant', on_delete=models.CASCADE, related_name='detail_info', null=True)
    keywords = models.CharField(max_length=255)
    description = models.TextField()
    avatar_image = models.ImageField(upload_to=detail_info_image_upload_path)
    cover_image = models.ImageField(upload_to=detail_info_image_upload_path)
    facade_image = models.ImageField(upload_to=detail_info_image_upload_path)
    restaurant_type = models.CharField(max_length=255)
    cuisine = models.CharField(max_length=255)  
    specialty_dishes = models.CharField(max_length=255)  
    serving_times = models.CharField(max_length=255)  
    target_audience = models.CharField(max_length=255)  
    purpose = models.CharField(max_length=255)
    operating_hours = models.JSONField(
        default=default_operating_hours,
        validators=[validate_operating_hours],
        help_text="JSON format: {'day': [{'open': 'HH:MM', 'close': 'HH:MM'}, ...] for each day}"
    )
    
    def __str__(self):
        return f"{self.restaurant.name if self.restaurant else 'Unnamed Restaurant'} - Details"
    
    def clean(self):
        super().clean()
        if self.operating_hours:
            validate_operating_hours(json.dumps(self.operating_hours))