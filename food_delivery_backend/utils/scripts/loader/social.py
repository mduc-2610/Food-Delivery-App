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

@transaction.atomic
def load_social(
        max_posts=6, 
        max_comments=20, 
        max_post_likes=30,
        max_comment_likes=30,
        max_post_images=15,
        max_comment_images=5
    ):
    model_list = [
        Post, CommentLike, PostLike, 
        PostImage, CommentImage, Comment
    ]
    
    for model in model_list:
        model.objects.all().delete()
    
    user_list = list(User.objects.all())
    
    print("________________________________________________________________")
    print("POSTS:")
    post_list = load_one_to_many_model(
        model_class=Post,
        primary_field='user',
        primary_objects=user_list,
        max_related_count=max_posts,
        attributes= {
            "title": lambda: fake.sentence(nb_words=6),
            "content": lambda: fake.text(max_nb_chars=200)
        }
    )

    print("________________________________________________________________")
    print("COMMENTS:")
    comment_list = load_intermediate_model(
        model_class=Comment,
        primary_field='post',
        related_field='user',
        primary_objects=post_list,
        related_objects=user_list,
        max_items=max_comments,
        attributes={'text': lambda: fake.text(max_nb_chars=200)}
    )

    print("________________________________________________________________")
    print("COMMENT LIKES:")
    load_intermediate_model(
        model_class=CommentLike,
        primary_field='comment',
        related_field='user',
        primary_objects=comment_list,
        related_objects=user_list,
        max_items=max_comment_likes
    )

    print("________________________________________________________________")
    print("POST LIKES:")
    load_intermediate_model(
        model_class=PostLike,
        primary_field='post',
        related_field='user',
        primary_objects=post_list,
        related_objects=user_list,
        max_items=max_post_likes
    )

    print("________________________________________________________________")
    print("POST IMAGES:")
    load_one_to_many_model(
        model_class=PostImage,
        primary_field='post',
        primary_objects=post_list,
        max_related_count=max_post_images,
        attributes={
            "image": lambda: fake.image_url()
        }
    )

    print("________________________________________________________________")
    print("COMMENT IMAGES:")
    load_one_to_many_model(
        model_class=CommentImage,
        primary_field='comment',
        primary_objects=comment_list,
        max_related_count=max_comment_images,
        attributes={
            "image": lambda: fake.image_url()
        }
    )

    return post_list, comment_list

def run():
    load_social()