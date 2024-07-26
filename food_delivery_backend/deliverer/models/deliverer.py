import uuid
from django.db import models

class Deliverer(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="deliverer")
    basic_info = models.OneToOneField("deliverer.BasicInfo", on_delete=models.CASCADE, related_name="deliverer")
    residency_info = models.OneToOneField("deliverer.ResidencyInfo", on_delete=models.CASCADE, related_name="deliverer")
    driver_license_and_vehicle = models.OneToOneField("deliverer.DriverLicense", on_delete=models.CASCADE, related_name="deliverer")
    other_info = models.OneToOneField("deliverer.OtherInfo", on_delete=models.CASCADE, related_name="deliverer")
    address = models.OneToOneField("deliverer.Address", on_delete=models.CASCADE, related_name="deliverer")
    operation_info = models.OneToOneField("deliverer.OperationInfo", on_delete=models.CASCADE, related_name="deliverer")
    emergency_contact = models.OneToOneField("deliverer.EmergencyContact", on_delete=models.CASCADE, related_name="deliverer")

    def __str__(self):
        return f"{self.id} {self.basic_info}"