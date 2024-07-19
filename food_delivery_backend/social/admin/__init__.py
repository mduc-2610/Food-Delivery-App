from django.contrib import admin

from .comment import CommentAdmin
from .image import CommentImageAdmin, PostImageAdmin
from .like import LikeAdmin
from .post import PostAdmin

from social.models import (
    Comment,
    CommentImage, PostImage,
    Like, 
    Post
)

admin.site.register(Comment, CommentAdmin)
admin.site.register(CommentImage, CommentImageAdmin)
admin.site.register(PostImage, PostImageAdmin)
admin.site.register(Like, LikeAdmin)
admin.site.register(Post, PostAdmin)
