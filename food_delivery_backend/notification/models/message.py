import uuid
from django.db import models

class BaseMessage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", on_delete=models.CASCADE)
    content = models.TextField(blank=True, null=True)
    latitude = models.DecimalField(max_digits=9, decimal_places=6, blank=True, null=True)
    longitude = models.DecimalField(max_digits=9, decimal_places=6, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        abstract = True

    def __str__(self):
        return f'{self.user.phone_number}: {self.content or "No Content"}'

class DirectMessage(BaseMessage):
    room = models.ForeignKey('notification.DirectRoom', on_delete=models.CASCADE, blank=True, null=True)

    class Meta:
        verbose_name = "Direct Message"
        verbose_name_plural = "Direct Messages"

class GroupMessage(BaseMessage):
    room = models.ForeignKey('notification.GroupRoom', on_delete=models.CASCADE, blank=True, null=True)

    class Meta:
        verbose_name = "Group Message"
        verbose_name_plural = "Group Messages"


class BaseImageMessage(models.Model):
    image = models.ImageField(upload_to='chat_images/', blank=True, null=True)

    class Meta:
        abstract = True

    def __str__(self):
        return f"{self.__class__.__name__} for {self.message.id}"

class DirectImageMessage(BaseImageMessage):
    message = models.ForeignKey("notification.DirectMessage", on_delete=models.CASCADE, blank=True, null=True)
    class Meta:
        verbose_name = "Direct Image Message"
        verbose_name_plural = "Direct Image Messages"

class GroupImageMessage(BaseImageMessage):
    message = models.ForeignKey("notification.GroupMessage", on_delete=models.CASCADE, blank=True, null=True)
    class Meta:
        verbose_name = "Group Image Message"
        verbose_name_plural = "Group Image Messages"



class BaseVideoMessage(models.Model):
    video = models.FileField(upload_to='chat_videos/', blank=True, null=True)

    class Meta:
        abstract = True

    def __str__(self):
        return f"{self.__class__.__name__} for {self.message.id}"

class DirectVideoMessage(BaseVideoMessage):
    message = models.ForeignKey("notification.DirectMessage", on_delete=models.CASCADE, blank=True, null=True)
    class Meta:
        verbose_name = "Direct Video Message"
        verbose_name_plural = "Direct Video Messages"

class GroupVideoMessage(BaseVideoMessage):
    message = models.ForeignKey("notification.GroupMessage", on_delete=models.CASCADE, blank=True, null=True)
    class Meta:
        verbose_name = "Group Video Message"
        verbose_name_plural = "Group Video Messages"

