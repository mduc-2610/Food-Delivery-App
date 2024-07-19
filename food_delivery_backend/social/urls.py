from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PostImageViewSet, 
    CommentImageViewSet, 
    CommentViewSet, 
    LikeViewSet, 
    PostViewSet
)

router = DefaultRouter()
router.register(r'comments', CommentViewSet)
router.register(r'post-images', PostImageViewSet)
router.register(r'comment-images', CommentImageViewSet)
router.register(r'likes', LikeViewSet)
router.register(r'posts', PostViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
