import sys
from faker import Faker
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
from utils.function import load_intermediate_model, load_one_to_many_model
from utils.decorators import script_runner

fake = Faker()

MODEL_MAP = {
    'dish_review': DishReview,
    'deliverer_review': DelivererReview,
    'restaurant_review': RestaurantReview,
    'delivery_review': DeliveryReview,
}

LIKE_MODEL_MAP = {
    DishReview: DishReviewLike,
    DelivererReview: DelivererReviewLike,
    RestaurantReview: RestaurantReviewLike,
    DeliveryReview: DeliveryReviewLike,
}

REVIEW_ATTRIBUTES = {
    'rating': lambda: fake.random_int(min=1, max=5),
    'title': lambda: fake.sentence(nb_words=6),
    'content': lambda: fake.text(max_nb_chars=200)
}


@script_runner(MODEL_MAP)
@transaction.atomic
def load_review(
    max_reviews=50, 
    max_likes_per_review=100,
    models_to_update=None,
    map_queryset=None,
    action=None,
):  
    review_map = {}
    if DishReview in models_to_update:
        dishes = list(Dish.objects.all())
        users = list(User.objects.all())
        print("________________________________________________________________")
        print("DISH REVIEWS:")
        review_map[DishReviewLike] = load_intermediate_model(
            model_class=DishReview,
            primary_field='user',
            related_field='dish',
            primary_objects=users,
            related_objects=dishes,
            max_items=max_reviews,
            attributes=REVIEW_ATTRIBUTES,
            action=action
        )

    if DelivererReview in models_to_update:
        deliverers = list(Deliverer.objects.all())
        users = list(User.objects.all())
        print("________________________________________________________________")
        print("DELIVERER REVIEWS:")
        review_map[DelivererReviewLike] = load_intermediate_model(
            model_class=DelivererReview,
            primary_field='user',
            related_field='deliverer',
            primary_objects=users,
            related_objects=deliverers,
            max_items=max_reviews,
            attributes=REVIEW_ATTRIBUTES,
            action=action
        )

    if RestaurantReview in models_to_update:
        restaurants = list(Restaurant.objects.all())
        users = list(User.objects.all())
        print("________________________________________________________________")
        print("RESTAURANT REVIEWS:")
        review_map[RestaurantReviewLike] = load_intermediate_model(
            model_class=RestaurantReview,
            primary_field='user',
            related_field='restaurant',
            primary_objects=users,
            related_objects=restaurants,
            max_items=max_reviews,
            attributes=REVIEW_ATTRIBUTES,
            action=action
        )

    if DeliveryReview in models_to_update:
        deliveries = list(Delivery.objects.all())
        users = list(User.objects.all())
        print("________________________________________________________________")
        print("DELIVERY REVIEWS:")
        review_map[DeliveryReviewLike] = load_intermediate_model(
            model_class=DeliveryReview,
            primary_field='user',
            related_field='delivery',
            primary_objects=users,
            related_objects=deliveries,
            max_items=max_reviews,
            attributes=REVIEW_ATTRIBUTES,
            action=action
        )

    print("________________________________________________________________")
    print("REVIEW LIKES:")
    for _model in models_to_update if models_to_update else MODEL_MAP.keys():
            like_model = LIKE_MODEL_MAP.get(_model)
            reviews = review_map.get(like_model)
            load_intermediate_model(
                model_class=like_model,
                primary_field='user',
                related_field='review',
                primary_objects=users,
                related_objects=reviews,
                max_items=max_likes_per_review,
                action=action
            )

def run(*args):
    if len(args) > 0:
        action = args[0]
        models = args[1:] if len(args) > 1 else []
        load_review(action, *models)
    else:
        load_review()