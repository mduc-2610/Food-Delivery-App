import uuid
from django.db import models

class Deliverer(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="deliverer")
    basic_info = models.OneToOneField("deliverer.BasicInfo", on_delete=models.CASCADE, related_name="basic_info")
    residency_info = models.OneToOneField("deliverer.ResidencyInfo", on_delete=models.CASCADE, related_name="residency_info")
    driver_license_and_vehicle = models.OneToOneField("deliverer.DriverLicense", on_delete=models.CASCADE, related_name="driver_license")
    other_info = models.OneToOneField("deliverer.OtherInfo", on_delete=models.CASCADE, related_name="other_info")
    address = models.OneToOneField("deliverer.Address", on_delete=models.CASCADE, related_name="address")
    operation_info = models.OneToOneField("deliverer.OperationInfo", on_delete=models.CASCADE, related_name="operation_info")
    emergency_contact = models.OneToOneField("deliverer.EmergencyContact", on_delete=models.CASCADE, related_name="emergency_contact")

    def __str__(self):
        return self.basic_info.email