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
router.register(r'comment', CommentViewSet)
router.register(r'post-image', PostImageViewSet)
router.register(r'comment-image', CommentImageViewSet)
router.register(r'comment-like', CommentLikeViewSet)
router.register(r'post-like', PostLikeViewSet)
router.register(r'post', PostViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
