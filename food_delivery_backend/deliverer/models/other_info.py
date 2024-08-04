from django.db import models

class OtherInfo(models.Model):
    deliverer = models.OneToOneField("deliverer.Deliverer", on_delete=models.CASCADE, related_name="other_info", null=True)
    occupation = models.CharField(max_length=100)
    details = models.TextField()
    judicial_record = models.ImageField(upload_to='judicial_records/')
    
    def __str__(self):
        return self.occupation