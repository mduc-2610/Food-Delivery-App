from django.db import models
import uuid

class Message(models.Model):
    MESSAGE_TYPES = (
        ('text', 'Text'),
        ('image', 'Image'),
        ('audio', 'Audio'),
        ('location', 'Location'),
    )
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    sender = models.ForeignKey("account.User", on_delete=models.CASCADE, related_name='sent_messages')
    receiver = models.ForeignKey("account.User", on_delete=models.CASCADE, related_name='received_messages')
    message_type = models.CharField(max_length=20, choices=MESSAGE_TYPES)
    content = models.TextField(blank=True, null=True)
    timestamp = models.DateTimeField(auto_now_add=True)
    read_status = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.sender} -> {self.receiver} ({self.timestamp})"

    class Meta:
        unique_together = ('sender', 'receiver')
        ordering = ['timestamp']

class ImageMessage(models.Model):
    message = models.OneToOneField(Message, on_delete=models.CASCADE, related_name='image_content')
    image = models.ImageField(upload_to='messages/images/')

class AudioMessage(models.Model):
    message = models.OneToOneField(Message, on_delete=models.CASCADE, related_name='audio_content')
    audio = models.FileField(upload_to='messages/audio/')

class LocationMessage(models.Model):
    message = models.OneToOneField(Message, on_delete=models.CASCADE, related_name='location_content')
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
