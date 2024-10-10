import uuid, os
from django.utils import timezone

from django.db import models
from django.contrib.contenttypes.fields import GenericForeignKey, GenericRelation
from django.contrib.contenttypes.models import ContentType


def upload_path(instance, filename):
    content_type = instance.content_type.model
    object_id = str(instance.object_id)
    now = timezone.now()
    return os.path.join(
        'review',
        content_type,  
        now.strftime("%Y/%m/%d"),
        object_id,  
        filename,
    )

class ReviewImage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    image = models.ImageField(upload_to=upload_path, max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    object_id = models.UUIDField()
    parent = GenericForeignKey('content_type', 'object_id')

    def __str__(self):
        return f"Image {self.id} for {self.parent}"
