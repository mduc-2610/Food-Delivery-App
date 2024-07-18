import uuid 
from django.db import models

class Like(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    post = models.ForeignKey("social.Post", related_name="user_likes", on_delete=models.CASCADE)
    user = models.ForeignKey("account.User", related_name="post_likes", on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Like by {self.user.username} on {self.post.title}"
