import sys
from faker import Faker
import random
from django.db import transaction

from food.models import Dish
from deliverer.models import Deliverer
from restaurant.models import Restaurant
from order.models import Delivery
from account.models import User
from review.models import (
    DishReview, DelivererReview, RestaurantReview, DeliveryReview,
    DishReviewLike, RestaurantReviewLike, DelivererReviewLike, DeliveryReviewLike
)

from utils.function import load_intermediate_model

fake = Faker()

MODEL_MAP = {
    'deliverer_review': DelivererReview,
    'restaurant_review': RestaurantReview,
    'delivery_review': DeliveryReview
}

LIKE_MODEL_MAP = {
    'deliverer_review': DelivererReviewLike,
    'restaurant_review': RestaurantReviewLike,
    'delivery_review': DeliveryReviewLike
}

REVIEW_ATTRIBUTES = {
    'rating': lambda: fake.random_int(min=1, max=5),
    'title': lambda: fake.sentence(nb_words=6),
    'content': lambda: fake.text(max_nb_chars=200)
}

@transaction.atomic
def load_review(
    max_reviews=50, 
    max_review_likes=100,
    models_to_update=None
):
    all_objects = {model: model.objects.all() for model in MODEL_MAP.values()}

    if models_to_update is None or models_to_update:
        if models_to_update:
            models_to_update_classes = [MODEL_MAP[m] for m in models_to_update if m in MODEL_MAP]
        else:
            models_to_update_classes = MODEL_MAP.values()

        users = list(User.objects.all())

        if DelivererReview in models_to_update_classes:
            deliverers = list(Deliverer.objects.all())
            print("________________________________________________________________")
            print("DELIVERER REVIEWS:")
            review_map = {
                DelivererReviewLike: load_intermediate_model(
                    model_class=DelivererReview,
                    primary_field='user',
                    related_field='deliverer',
                    primary_objects=users,
                    related_objects=deliverers,
                    max_items=max_reviews,
                    attributes=REVIEW_ATTRIBUTES
                )
            }

        if RestaurantReview in models_to_update_classes:
            restaurants = list(Restaurant.objects.all())
            print("________________________________________________________________")
            print("RESTAURANT REVIEWS:")
            review_map[RestaurantReviewLike] = load_intermediate_model(
                model_class=RestaurantReview,
                primary_field='user',
                related_field='restaurant',
                primary_objects=users,
                related_objects=restaurants,
                max_items=max_reviews,
                attributes=REVIEW_ATTRIBUTES
            )

        if DeliveryReview in models_to_update_classes:
            deliveries = list(Delivery.objects.all())
            print("________________________________________________________________")
            print("DELIVERY REVIEWS:")
            review_map[DeliveryReviewLike] = load_intermediate_model(
                model_class=DeliveryReview,
                primary_field='user',
                related_field='delivery',
                primary_objects=users,
                related_objects=deliveries,
                max_items=max_reviews,
                attributes=REVIEW_ATTRIBUTES
            )

        print("________________________________________________________________")
        print("REVIEW LIKES:")
        for like_model, reviews in review_map.items():
            load_intermediate_model(
                model_class=like_model,
                primary_field='user',
                related_field='review',
                primary_objects=users,
                related_objects=reviews,
                max_items=max_review_likes
            )

def delete_models(models_to_delete):
    """
    Deletes all records from specified models.
    """
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
        load_review(models_to_update=models_to_update)
    elif action not in ['delete', 'update']:
        print("Invalid action. Use 'delete' or 'update'.")
