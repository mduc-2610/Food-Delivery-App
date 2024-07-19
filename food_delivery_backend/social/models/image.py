import uuid
from django.db import models
from django.core.exceptions import ValidationError

def validate_image_size(image):
    file_size = image.file.size
    limit_mb = 5
    if file_size > limit_mb * 1024 * 1024:
        raise ValidationError(f"Max size of file is {limit_mb} MB")

class BaseImage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    image = models.ImageField(upload_to='images/', validators=[validate_image_size])

    class Meta:
        abstract = True

class PostImage(BaseImage):
    post = models.ForeignKey("social.Post", related_name="post_images", on_delete=models.CASCADE)

    def __str__(self):
        return f"Image for post: {self.post.title}"

class CommentImage(BaseImage):
    comment = models.ForeignKey("social.Comment", related_name="comment_images", on_delete=models.CASCADE)

    def __str__(self):
        return f"Image for comment by: {self.comment.user.username}"
