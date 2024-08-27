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

fake = Faker()

MODEL_MAP = {
    'post': Post,
    'post_like': PostLike,
    'comment_like': CommentLike,
    'post_image': PostImage,
    'comment_image': CommentImage,
    'comment': Comment
}

@transaction.atomic
def load_social(
        max_posts=6, 
        max_comments=20, 
        max_post_likes=30,
        max_comment_likes=30,
        max_post_images=15,
        max_comment_images=5,
        models_to_update=None
    ):
    all_objects = {model: model.objects.all() for model in MODEL_MAP.values()}

    if models_to_update is None or models_to_update:
        if models_to_update:
            models_to_update_classes = [MODEL_MAP[m] for m in models_to_update if m in MODEL_MAP]
        else:
            models_to_update_classes = MODEL_MAP.values()

        if Post in models_to_update_classes:
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
                }
            )
        
        if Comment in models_to_update_classes:
            print("________________________________________________________________")
            print("COMMENTS:")
            post_list = all_objects.get(Post, [])
            user_list = list(User.objects.all())
            comment_list = load_intermediate_model(
                model_class=Comment,
                primary_field='post',
                related_field='user',
                primary_objects=post_list,
                related_objects=user_list,
                max_items=max_comments,
                attributes={'text': lambda: fake.text(max_nb_chars=200)}
            )
        
        if CommentLike in models_to_update_classes:
            print("________________________________________________________________")
            print("COMMENT LIKES:")
            comment_list = all_objects.get(Comment, [])
            user_list = list(User.objects.all())
            load_intermediate_model(
                model_class=CommentLike,
                primary_field='comment',
                related_field='user',
                primary_objects=comment_list,
                related_objects=user_list,
                max_items=max_comment_likes
            )
        
        if PostLike in models_to_update_classes:
            print("________________________________________________________________")
            print("POST LIKES:")
            post_list = all_objects.get(Post, [])
            user_list = list(User.objects.all())
            load_intermediate_model(
                model_class=PostLike,
                primary_field='post',
                related_field='user',
                primary_objects=post_list,
                related_objects=user_list,
                max_items=max_post_likes
            )
        
        if PostImage in models_to_update_classes:
            print("________________________________________________________________")
            print("POST IMAGES:")
            post_list = all_objects.get(Post, [])
            load_one_to_many_model(
                model_class=PostImage,
                primary_field='post',
                primary_objects=post_list,
                max_related_objects=max_post_images,
                attributes={
                    "image": lambda: fake.image_url()
                }
            )
        
        if CommentImage in models_to_update_classes:
            print("________________________________________________________________")
            print("COMMENT IMAGES:")
            comment_list = all_objects.get(Comment, [])
            load_one_to_many_model(
                model_class=CommentImage,
                primary_field='comment',
                primary_objects=comment_list,
                max_related_objects=max_comment_images,
                attributes={
                    "image": lambda: fake.image_url()
                }
            )

def delete_models(models_to_delete):
    for model in models_to_delete:
        model.objects.all().delete()

def run(*args):
    action = args[0] if args else None

    if action == 'delete':
        models_to_delete = args[1:] if len(args) > 1 else MODEL_MAP.keys()
        delete_models([MODEL_MAP[m] for m in models_to_delete if m in MODEL_MAP])
        models_to_update = args[1:] if len(args) > 1 else None
    elif action == 'update':
        models_to_update = args[1:] if len(args) > 1 else None
    else:
        models_to_update = None

    if models_to_update is not None or action is None:
        load_social(models_to_update=models_to_update)
    elif action not in ['delete', 'update']:
        print("Invalid action. Use 'delete' or 'update'.")
