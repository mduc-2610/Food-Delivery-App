import os
import uuid
from django.db import models
from django.db.models.signals import pre_save, post_save
from django.dispatch import receiver
from django.utils import timezone
from django.core.files.storage import default_storage

class BaseMessage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", on_delete=models.CASCADE)
    content = models.TextField(default="", null=True, blank=True)
    latitude = models.DecimalField(max_digits=9, decimal_places=6, blank=True, null=True)
    longitude = models.DecimalField(max_digits=9, decimal_places=6, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    class Meta:
        abstract = True
        ordering = ("created_at",)

    def __str__(self):
        return f'{self.user.phone_number}: {self.content or "No Content"}'

class DirectMessage(BaseMessage):
    room = models.ForeignKey('notification.DirectRoom', related_name='messages', on_delete=models.CASCADE, blank=True, null=True)

    class Meta:
        verbose_name = "Direct Message"
        verbose_name_plural = "Direct Messages"

class GroupMessage(BaseMessage):
    room = models.ForeignKey('notification.GroupRoom', related_name='messages', on_delete=models.CASCADE, blank=True, null=True)

    class Meta:
        verbose_name = "Group Message"
        verbose_name_plural = "Group Messages"


def update_room_latest_message(sender, instance, created, **kwargs):
    if created:
        room = instance.room
        print('sdad', instance, room, pretty=True)
        room.latest_message = instance
        room.save(update_fields=['latest_message'])

post_save.connect(update_room_latest_message, sender=DirectMessage)
post_save.connect(update_room_latest_message, sender=GroupMessage)

def user_media_upload_path(instance, filename, media_type):
    message = instance.message
    now = timezone.now()
    return os.path.join(
        'chat',
        media_type, 
        now.strftime("%Y/%m/%d"), 
        str(message.id), 
        filename,
    )

def user_image_upload_path(instance, filename):
    return user_media_upload_path(instance, filename, 'image')

def user_video_upload_path(instance, filename):
    return user_media_upload_path(instance, filename, 'video')

class BaseImageMessage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    image = models.ImageField(upload_to=user_image_upload_path, blank=True, null=True)

    class Meta:
        abstract = True

    def __str__(self):
        return f"{self.__class__.__name__} for {self.image}"

class DirectImageMessage(BaseImageMessage):
    message = models.ForeignKey("notification.DirectMessage", related_name='images', on_delete=models.CASCADE, blank=True, null=True)
    class Meta:
        verbose_name = "Direct Image Message"
        verbose_name_plural = "Direct Image Messages"

class GroupImageMessage(BaseImageMessage):
    message = models.ForeignKey("notification.GroupMessage", related_name='images', on_delete=models.CASCADE, blank=True, null=True)
    class Meta:
        verbose_name = "Group Image Message"
        verbose_name_plural = "Group Image Messages"



class BaseVideoMessage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    video = models.FileField(upload_to=user_video_upload_path,  blank=True, null=True)

    class Meta:
        abstract = True

    def __str__(self):
        return f"{self.__class__.__name__} {self.video}"

class DirectVideoMessage(BaseVideoMessage):
    message = models.ForeignKey("notification.DirectMessage", related_name='videos', on_delete=models.CASCADE, blank=True, null=True)
    class Meta:
        verbose_name = "Direct Video Message"
        verbose_name_plural = "Direct Video Messages"

class GroupVideoMessage(BaseVideoMessage):
    message = models.ForeignKey("notification.GroupMessage", related_name='videos', on_delete=models.CASCADE, blank=True, null=True)
    class Meta:
        verbose_name = "Group Video Message"
        verbose_name_plural = "Group Video Messages"

# def generate_upload_path(instance, filename, base_path):
#     now = timezone.now()
#     if hasattr(instance, 'user') and instance.user:
#         username = instance.user.profile.name
#     elif hasattr(instance, 'message') and instance.message and instance.message.user:
#         username = instance.message.user.profile.name
#     else:
#         username = 'unknown_user'
#     return os.path.join(base_path, username, now.strftime("%Y/%m/%d"), filename)


# @receiver(post_save, sender=DirectImageMessage)
# def move_image_file(sender, instance, created, **kwargs):
#     if created and instance.image:
#         old_path = instance.image.path
        
#         print(instance.id, instance.image, pretty=True)
#         _instance = DirectImageMessage.objects.get(id=instance.id)
#         print(_instance.message, pretty=True)
#         if not os.path.exists(old_path):
#             print(f"Source file does not exist: {old_path}")
#             return

#         new_path = generate_upload_path(instance, os.path.basename(old_path), 'chat_image')
#         # new_path = default_storage.get_available_name(new_path)
        
#         # os.makedirs(os.path.dirname(new_path), exist_ok=True)
        
#         try:
#             default_storage.save(new_path, instance.image)
            
#             instance.image.name = new_path
#             instance.save(update_fields=['image'])
#             print(old_path, new_path, pretty=True)
#             if default_storage.exists(old_path):
#                 default_storage.delete(old_path)
            
#         except Exception as e:
#             print(f"Error moving file: {str(e)}")

# @receiver(post_save, sender=BaseVideoMessage)
# def move_video_file(sender, instance, created, **kwargs):
#     if created and instance.video:
#         old_path = instance.video.path
        
#         if not os.path.exists(old_path):
#             print(f"Source file does not exist: {old_path}")
#             return

#         new_path = generate_upload_path(instance, os.path.basename(old_path), 'chat_video')
#         # new_path = default_storage.get_available_name(new_path)
        
#         # os.makedirs(os.path.dirname(new_path), exist_ok=True)
        
#         try:
#             default_storage.save(new_path, instance.video)
            
#             instance.video.name = new_path
#             instance.save(update_fields=['video'])
#             print(old_path, new_path, pretty=True)
#             if default_storage.exists(old_path):
#                 default_storage.delete(old_path)
            
#         except Exception as e:
#             print(f"Error moving file: {str(e)}")