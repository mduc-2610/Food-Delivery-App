import sys
from faker import Faker
import random
from django.db import transaction

from account.models import User
from social.models import (
    Post, PostLike, CommentLike,
    PostImage, CommentImage, Comment
)
from utils.function import load_intermediate_model, load_one_to_many_model
from utils.decorators import script_runner

fake = Faker()

MODEL_MAP = {
    'post': Post,
    'post_like': PostLike,
    'comment_like': CommentLike,
    'post_image': PostImage,
    'comment_image': CommentImage,
    'comment': Comment
}

@script_runner(MODEL_MAP)
@transaction.atomic
def load_social(
    max_posts=6, 
    max_comments=20, 
    max_likes_per_post=30,
    max_likes_per_comment=30,
    max_images_per_post=15,
    max_images_per_comment=5,
    models_to_update=None,
    map_queryset=None,
    action=None,
):
    if Post in models_to_update:
        user_list = list(User.objects.all())
        print("________________________________________________________________")
        print("POSTS:")
        post_list = load_one_to_many_model(
            model_class=Post,
            primary_field='user',
            primary_objects=user_list,
            max_related_objects=max_posts,
            attributes={
                "title": lambda: fake.sentence(nb_words=6),
                "content": lambda: fake.text(max_nb_chars=200)
            },
            action=action
        )
    
    if Comment in models_to_update:
        print("________________________________________________________________")
        print("COMMENTS:")
        post_list = map_queryset.get(Post)
        user_list = list(User.objects.all())
        comment_list = load_intermediate_model(
            model_class=Comment,
            primary_field='post',
            related_field='user',
            primary_objects=post_list,
            related_objects=user_list,
            max_items=max_comments,
            attributes={'text': lambda: fake.text(max_nb_chars=200)},
            action=action
        )
    
    if CommentLike in models_to_update:
        print("________________________________________________________________")
        print("COMMENT LIKES:")
        comment_list = map_queryset.get(Comment)
        user_list = list(User.objects.all())
        load_intermediate_model(
            model_class=CommentLike,
            primary_field='comment',
            related_field='user',
            primary_objects=comment_list,
            related_objects=user_list,
            max_items=max_likes_per_comment,
            action=action
        )
    
    if PostLike in models_to_update:
        print("________________________________________________________________")
        print("POST LIKES:")
        post_list = map_queryset.get(Post)
        user_list = list(User.objects.all())
        load_intermediate_model(
            model_class=PostLike,
            primary_field='post',
            related_field='user',
            primary_objects=post_list,
            related_objects=user_list,
            max_items=max_likes_per_post,
            action=action
        )
    
    if PostImage in models_to_update:
        print("________________________________________________________________")
        print("POST IMAGES:")
        post_list = map_queryset.get(Post)
        load_one_to_many_model(
            model_class=PostImage,
            primary_field='post',
            primary_objects=post_list,
            max_related_objects=max_images_per_post,
            attributes={
                "image": lambda: fake.image_url()
            },
            action=action
        )
    
    if CommentImage in models_to_update:
        print("________________________________________________________________")
        print("COMMENT IMAGES:")
        comment_list = map_queryset.get(Comment)
        load_one_to_many_model(
            model_class=CommentImage,
            primary_field='comment',
            primary_objects=comment_list,
            max_related_objects=max_images_per_comment,
            attributes={
                "image": lambda: fake.image_url()
            },
            action=action,
        )


def run(*args):
    if len(args) > 0:
        action = args[0]
        models = args[1:] if len(args) > 1 else []
        load_social(action, *models)
    else:
        load_social()