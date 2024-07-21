from django.contrib import admin

from .comment import CommentAdmin
from .image import CommentImageAdmin, PostImageAdmin
from .like import CommentLikeAdmin, PostLikeAdmin
from .post import PostAdmin

from social.models import (
    Comment,
    CommentImage, PostImage,
    CommentLike, PostLike,
    Post
)

admin.site.register(Comment, CommentAdmin)
admin.site.register(CommentImage, CommentImageAdmin)
admin.site.register(PostImage, PostImageAdmin)
admin.site.register(CommentLike, CommentLikeAdmin)
admin.site.register(PostLike, PostLikeAdmin)
admin.site.register(Post, PostAdmin)
