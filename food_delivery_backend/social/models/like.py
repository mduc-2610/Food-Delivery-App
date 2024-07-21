import uuid
from django.db import models

class BaseLike(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    user = models.ForeignKey("account.User", related_name="%(class)s_likes", on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        abstract = True
        ordering = ('-created_at',)

    def __str__(self):
        return f"Like by {self.user}"

class PostLike(BaseLike):
    post = models.ForeignKey("social.Post", related_name="likes", on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'post')  

    def __str__(self):
        return f"PostLike by {self.user} on {self.post.title}"

class CommentLike(BaseLike):
    comment = models.ForeignKey("social.Comment", related_name="likes", on_delete=models.CASCADE)

    class Meta:
        unique_together = ('user', 'comment')

    def __str__(self):
        return f"CommentLike by {self.user} on {self.comment.id}"
