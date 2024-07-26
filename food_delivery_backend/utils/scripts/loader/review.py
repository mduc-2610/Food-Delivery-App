from faker import Faker
import random

from django.utils import timezone

from food.models import Dish
from deliverer.models import Deliverer
from restaurant.models import Restaurant
from order.models import Order
from account.models import User
from review.models import (
    DishReview, DelivererReview, RestaurantReview, OrderReview,
    DishReviewLike, RestaurantReviewLike, DelivererReviewLike, OrderReviewLike
)

from utils.function import load_intermediate_model

fake = Faker()

def load_review(
        max_reviews=50, 
        max_review_likes=100,
    ):
    review_model_map = {
        # DishReview: ('user', 'dish', list(User.objects.all()), list(Dish.objects.all())),
        DelivererReview: ('user', 'deliverer', list(User.objects.all()), list(Deliverer.objects.all())),
        RestaurantReview: ('user', 'restaurant', list(User.objects.all()), list(Restaurant.objects.all())),
        OrderReview: ('user', 'order', list(User.objects.all()), list(Order.objects.all()))
    }
    
    for review_model in review_model_map.keys():
        review_model.objects.all().delete()

    users = list(User.objects.all())

    print("________________________________________________________________")
    print("REVIEWS:")
    review_map = {}
    like_model_map = {
        # DishReview: DishReviewLike,
        DelivererReview: DelivererReviewLike,
        RestaurantReview: RestaurantReviewLike,
        OrderReview: OrderReviewLike
    }

    review_attributes = {
        'rating': lambda: fake.random_int(min=1, max=5),
        'title': lambda: fake.sentence(nb_words=6),
        'comment': lambda: fake.text(max_nb_chars=200)
    }

    for review_model, (user_field, target_field, users, targets) in review_model_map.items():
        review_map.update({
            like_model_map[review_model]: load_intermediate_model(
                model_class=review_model,
                primary_field=user_field,
                related_field=target_field,
                primary_objects=users,
                related_objects=targets,
                max_items=max_reviews,
                attributes=review_attributes
            )
        })

    print("________________________________________________________________")
    print("REVIEW LIKES:")
    for like_model, reviews in review_map.items():
        load_intermediate_model(
            model_class=like_model,
            primary_field='user',
            related_field='review',
            primary_objects=users,
            related_objects=reviews,
            max_items=max_review_likes,
        )

    return review_map
