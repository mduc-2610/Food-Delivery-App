from django.db import models

class Setting(models.Model):
    user = models.OneToOneField("account.User", on_delete=models.CASCADE, related_name="setting", db_index=True)
    notification = models.BooleanField(default=True)
    dark_mode = models.BooleanField(default=False)
    sound = models.BooleanField(default=False)
    automatically_updated = models.BooleanField(default=False)
    LANGUAGE_CHOICES = (
        ("ENGLISH", "English"),
        ("Vietnamese", "Vietnamese"),
    )
    language = models.CharField(max_length=30, choices=LANGUAGE_CHOICES, default="ENGLISH")

class SecuritySetting(models.Model):
    setting = models.OneToOneField("account.Setting", on_delete=models.CASCADE, related_name="security_setting", db_index=True)
    face_id = models.BooleanField(default=False)
    touch_id = models.BooleanField(default=False)
    pin_security = models.BooleanField(default=False)
