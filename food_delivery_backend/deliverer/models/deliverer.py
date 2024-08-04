import uuid
from django.db import models

class Deliverer(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="deliverer")
    basic_info = models.OneToOneField("deliverer.BasicInfo", on_delete=models.CASCADE, related_name="deliverer", null=True)
    residency_info = models.OneToOneField("deliverer.ResidencyInfo", on_delete=models.CASCADE, related_name="deliverer", null=True)
    driver_license = models.OneToOneField("deliverer.DriverLicense", on_delete=models.CASCADE, related_name="deliverer", null=True)
    other_info = models.OneToOneField("deliverer.OtherInfo", on_delete=models.CASCADE, related_name="deliverer", null=True)
    address = models.OneToOneField("deliverer.Address", on_delete=models.CASCADE, related_name="deliverer", null=True)
    operation_info = models.OneToOneField("deliverer.OperationInfo", on_delete=models.CASCADE, related_name="deliverer", null=True)
    emergency_contact = models.OneToOneField("deliverer.EmergencyContact", on_delete=models.CASCADE, related_name="deliverer", null=True)
    
    def __getitem__(self, attr):
        if hasattr(self, attr):
            return getattr(self, attr)
        else:
            raise AttributeError(f"{attr} is not a valid attribute")

    def __str__(self):
        return f"{self.id} {self.basic_info}"