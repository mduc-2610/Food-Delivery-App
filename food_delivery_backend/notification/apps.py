from django.apps import AppConfig
from django.db.models.signals import post_save

class NotificationConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'notification'

    # def ready(self):
    #     from notification.models import BaseImageMessage, BaseVideoMessage, move_image_file, move_video_file
    #     post_save.connect(move_image_file, sender=BaseImageMessage)
    #     post_save.connect(move_video_file, sender=BaseVideoMessage)
