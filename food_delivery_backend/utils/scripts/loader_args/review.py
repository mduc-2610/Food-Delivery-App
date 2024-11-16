import sys, random
from faker import Faker
from django.db import transaction

from food.models import Dish
from deliverer.models import Deliverer
from restaurant.models import Restaurant
from order.models import Delivery
from account.models import User
from order.models import Order
from review.models import (
    DishReview, DelivererReview, RestaurantReview, DeliveryReview,
    DishReviewLike, RestaurantReviewLike, DelivererReviewLike, DeliveryReviewLike
)
from utils.function import (
    load_intermediate_model, 
    load_one_to_many_model,
    load_oto_with_more_than_two_fk, 
    load_normal_model
)
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


@script_runner(MODEL_MAP)
@transaction.atomic
def load_review(
    max_reviews=50, 
    max_likes_per_review=100,
    models_to_update=None,
    map_queryset=None,
    action=None,
):  
    orders = list(map_queryset.get(Order).filter(status='COMPLETED'))
    REVIEW_ATTRIBUTES = {
        'rating': lambda: fake.random_int(min=1, max=5),
        'title': lambda: fake.sentence(nb_words=6),
        'content': lambda: fake.text(max_nb_chars=200),
    }
    review_map = {}
    # if DishReview in models_to_update:
    #     dishes = list(Dish.objects.all())
    #     users = list(User.objects.all())
    #     review_map[DishReviewLike] = load_oto_with_more_than_two_fk(
    #         model_class=DishReview,
    #         oto_field='order',
    #         related_field_1='user',
    #         related_field_2='dish',
    #         oto_objects=orders,
    #         related_objects_1=users,
    #         related_objects_2=dishes,
    #         min_items=5,
    #         max_items=max_reviews,
    #         attributes=REVIEW_ATTRIBUTES,
    #         action=action
    #     )

    #  review_map[DishReviewLike] = load_intermediate_model(
        #     model_class=DishReview,
        #     primary_field='user',
        #     related_field='dish',
        #     primary_objects=users,
        #     related_objects=dishes,
        #     max_items=max_reviews,
        #     attributes=REVIEW_ATTRIBUTES,
        #     action=action
        # )

    """
    Dish is different because
    User rate food through order but that order contain many foods
    """
    
    if DishReview in models_to_update:
        dishes = list(Dish.objects.all())
        users = list(User.objects.all())
        for _order in orders:
            # has_inner_loop = random.randint(1, 3)
            # if has_inner_loop % 3 == 0: 
            if _order.status == 'COMPLETED':
                for _dish in _order.cart.dishes.all():
                    instance, created = DishReview.objects.get_or_create(
                        user=_order.cart.user,
                        dish=_dish.dish,
                        order=_order,
                        defaults=REVIEW_ATTRIBUTES
                    )

    if DelivererReview in models_to_update:
        deliverers = list(Deliverer.objects.all())
        users = list(User.objects.all())
        review_map[DelivererReviewLike] = []
        for _order in orders:
            if hasattr(_order, 'cart') and hasattr(_order, 'delivery') and hasattr(_order.delivery, 'deliverer'):
                instance, created = DelivererReview.objects.get_or_create(
                    user=_order.cart.user,
                    deliverer=_order.delivery.deliverer,
                    order=_order,
                    defaults=REVIEW_ATTRIBUTES
                )
                review_map[DelivererReviewLike].append(instance)
            else: 
                continue
        
        # review_map[DelivererReviewLike] = load_oto_with_more_than_two_fk(
        #     model_class=DelivererReview,
        #     oto_field='order',
        #     related_field_1='user',
        #     related_field_2='deliverer',
        #     oto_objects=orders,
        #     related_objects_1=users,
        #     related_objects_2=deliverers,
        #     min_items=5,
        #     max_items=max_reviews,
        #     attributes=REVIEW_ATTRIBUTES,
        #     action=action
        # )

    if RestaurantReview in models_to_update:
        restaurants = list(Restaurant.objects.all())
        users = list(User.objects.all())
        review_map[RestaurantReviewLike] = []
        for _order in orders:
            if hasattr(_order, 'cart') and hasattr(_order.cart, 'restaurant'):
                instance, created = RestaurantReview.objects.get_or_create(
                    user=_order.cart.user,
                    restaurant=_order.cart.restaurant,
                    order=_order,
                    defaults=REVIEW_ATTRIBUTES
                )
                review_map[RestaurantReviewLike].append(instance)
            else: 
                continue

        # review_map[RestaurantReviewLike] = load_oto_with_more_than_two_fk(
        #     model_class=RestaurantReview,
        #     oto_field='order',
        #     related_field_1='user',
        #     related_field_2='restaurant',
        #     oto_objects=orders,
        #     related_objects_1=users,
        #     related_objects_2=restaurants,
        #     min_items=5,
        #     max_items=max_reviews,
        #     attributes=REVIEW_ATTRIBUTES,
        #     action=action
        # )

    if DeliveryReview in models_to_update:
        deliveries = list(Delivery.objects.all())
        users = list(User.objects.all())
        review_map[DeliveryReviewLike] = []
        for _order in orders:
            if hasattr(_order, 'delivery'):
                instance, created = DeliveryReview.objects.get_or_create(
                    user=_order.cart.user,
                    delivery=_order.delivery,
                    order=_order,
                    defaults=REVIEW_ATTRIBUTES
                )
                review_map[DeliveryReviewLike].append(instance)
            else: 
                continue

        # review_map[DeliveryReviewLike] = load_oto_with_more_than_two_fk(
        #     model_class=DeliveryReview,
        #     oto_field='order',
        #     related_field_1='user',
        #     related_field_2='delivery',
        #     oto_objects=orders,
        #     related_objects_1=users,
        #     related_objects_2=deliveries,
        #     min_items=5,
        #     max_items=max_reviews,
        #     attributes=REVIEW_ATTRIBUTES,
        #     action=action
        # )

    for _model in models_to_update if models_to_update else MODEL_MAP.keys():
            like_model = LIKE_MODEL_MAP.get(_model)
            reviews = review_map.get(like_model)
            # load_intermediate_model(
            #     model_class=like_model,
            #     primary_field='user',
            #     related_field='review',
            #     primary_objects=users,
            #     related_objects=reviews,
            #     max_items=max_likes_per_review,
            #     action=action
            # )
            load_normal_model(
                model_class=like_model,
                max_items=0,
                oto_field='review',
                oto_objects=reviews,
                attributes={
                    'user': lambda: random.choice(users)
                },
                action=action
            )

def run(*args):
    load_review(*args)