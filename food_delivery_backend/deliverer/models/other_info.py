import os
from django.utils import timezone
from django.db import models


def other_info_image_upload_path(instance, filename):
    deliverer = instance.deliverer
    now = timezone.now()
    return os.path.join(
        'deliverer'
        'judicial_record',
        now.strftime("%Y/%m/%d"), 
        str(deliverer.id), 
        filename,
    )

class OtherInfo(models.Model):
    deliverer = models.OneToOneField("deliverer.Deliverer", on_delete=models.CASCADE, related_name="other_info", null=True)
    occupation = models.CharField(max_length=100)
    details = models.TextField()
    judicial_record = models.ImageField(upload_to=other_info_image_upload_path)
    
    def __str__(self):
        return self.occupation