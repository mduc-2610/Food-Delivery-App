from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PostImageViewSet, 
    CommentImageViewSet, 
    CommentViewSet, 
    CommentLikeViewSet, PostLikeViewSet, 
    PostViewSet
)

router = DefaultRouter()
router.register(r'comments', CommentViewSet)
router.register(r'post-images', PostImageViewSet)
router.register(r'comment-images', CommentImageViewSet)
router.register(r'comment-likes', CommentLikeViewSet)
router.register(r'post-likes', PostLikeViewSet)
router.register(r'posts', PostViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
