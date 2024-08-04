from django.db import models

class BasicInfo(models.Model):
    deliverer = models.OneToOneField("deliverer.Deliverer", on_delete=models.CASCADE, related_name="basic_info", null=True)
    full_name = models.CharField(max_length=100)
    given_name = models.CharField(max_length=50)
    gender = models.CharField(max_length=10, choices=[('MALE', 'Male'), ('FEMALE', 'Female'), ('OTHER', 'Other')])
    date_of_birth = models.DateField()
    hometown = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    district = models.CharField(max_length=100)
    ward = models.CharField(max_length=100)
    address = models.CharField(max_length=255)
    citizen_identification = models.CharField(max_length=20)
    
    def __str__(self):
        return self.full_name