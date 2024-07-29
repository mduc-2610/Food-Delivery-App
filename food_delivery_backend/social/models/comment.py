import uuid
from django.db import models

class Comment(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, db_index=True)
    post = models.ForeignKey("social.Post", related_name="user_comments", on_delete=models.CASCADE)
    user = models.ForeignKey("account.User", related_name="post_comments", on_delete=models.CASCADE)
    text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return f"Comment by {self.user} on {self.post.title}"
