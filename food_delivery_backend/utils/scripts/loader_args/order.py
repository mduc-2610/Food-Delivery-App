import sys
from faker import Faker
import random
from django.db import transaction

from account.models import User
from deliverer.models import Deliverer
from restaurant.models import Restaurant
from food.models import Dish
from order.models import (
    Promotion, ActivityPromotion, OrderPromotion, 
    RestaurantPromotion, UserPromotion, Order, 
    Delivery, DeliveryRequest, RestaurantCart, RestaurantCartDish
)

from utils.function import (
    load_intermediate_model, 
    load_normal_model,
    load_one_to_many_model,
    generate_latitude, generate_longitude
)
from utils.decorators import script_runner

fake = Faker()

MODEL_MAP = {
    'promotion': Promotion,
    'activity_promotion': ActivityPromotion,
    'order_promotion': OrderPromotion,
    'restaurant_promotion': RestaurantPromotion,
    'user_promotion': UserPromotion,
    'order': Order,
    'delivery': Delivery,
    'delivery_request': DeliveryRequest,
    'restaurant_cart': RestaurantCart,
    'restaurant_cart_dish': RestaurantCartDish,
}

@script_runner(MODEL_MAP)
@transaction.atomic
def load_order(
    max_promotions=200, 
    max_promotions_per_order=30, 
    max_promotions_per_restaurant=50, 
    max_promotions_per_user=40,
    max_deliveries_per_deliverer=100,
    max_restaurant_carts_per_user=12,
    max_dishes_per_restaurant_cart=10,
    models_to_update=None,
    map_queryset=None,
    action=None,
):
    if Promotion in models_to_update:
        promotion_list = load_normal_model(
            model_class=Promotion,
            max_items=max_promotions,
            attributes={
                "code": lambda: fake.unique.text(max_nb_chars=10).upper(),
                "description": lambda: fake.text(max_nb_chars=200),
                "promo_type": lambda: random.choice(['SHIPPING', 'ORDER', 'ACTIVITY']),
                "discount_percentage": lambda: fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
                "discount_amount": lambda: fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
                "start_date": lambda: fake.date_time_this_year(),
                "end_date": lambda: fake.date_time_this_year(),
                "applicable_scope": lambda: fake.text(max_nb_chars=50),
                "terms_and_conditions": lambda: fake.text(max_nb_chars=200),
                "active": lambda: fake.boolean()
            },
            action=action
        )

    if RestaurantCart in models_to_update:
        user_list = list(User.objects.all())
        restaurant_list = list(Restaurant.objects.all())
        load_intermediate_model(
            model_class=RestaurantCart,
            primary_field='user',
            related_field='restaurant',
            primary_objects=user_list,
            related_objects=restaurant_list,
            max_items=max_restaurant_carts_per_user,
            min_items=1,
            attributes={"is_created_order": True},
            action=action
        )

    if RestaurantCartDish in models_to_update:
        dish_list = list(Dish.objects.all())
        restaurant_cart_list = map_queryset.get(RestaurantCart)
        load_intermediate_model(
            model_class=RestaurantCartDish,
            primary_field='cart',
            related_field='dish',
            primary_objects=restaurant_cart_list,
            related_objects=dish_list,
            max_items=max_dishes_per_restaurant_cart,
            attributes={"quantity": lambda: fake.random_int(min=1, max=5)},
            action=action
        )

    if Order in models_to_update:
        DeliveryRequest.objects.all().delete()
        order_list = []
        promotion_list = map_queryset.get(Promotion)
        print(promotion_list)
        for _cart in restaurant_cart_list:
            user_location = _cart.user.locations.filter(is_selected=True).first()
            print(user_location, pretty=True)
            order_data = {
                "cart": _cart,
                "payment_method": fake.random_element(elements=('Credit Card', 'Paypal', 'Cash on Delivery')),
                "promotion": random.choice(promotion_list) if random.choice([True, False]) and not promotion_list else None,
                "discount":  random.uniform(0, 10),
                "status": fake.random_element(elements=['ACTIVE', 'CANCELLED', 'COMPLETED', 'PENDING']),
                "rating": random.randint(0, 5)
            }
            order = Order.objects.create(**order_data)
            order.create_delivery_and_request()
            order_list.append(order)
            print(f"\tSuccessfully created Order: {order}")

    if Delivery in models_to_update:
        deliverer_list = list(Deliverer.objects.all())
        order_list = map_queryset.get(Order)
        # load_intermediate_model(
        #     model_class=Delivery,
        #     primary_field='order',
        #     related_field='deliverer',
        #     primary_objects=order_list,
        #     related_objects=deliverer_list,
        #     max_items=max_deliveries_per_deliverer,
        #     attributes={
        #         "pickup_location": lambda: fake.address(),
        #         "pickup_latitude": generate_latitude,
        #         "pickup_longitude": generate_longitude,
        #         "dropoff_location": lambda: fake.address(),
        #         "dropoff_latitude": generate_latitude,
        #         "dropoff_longitude": generate_longitude,
        #         "status": lambda: random.choice(['FINDING_DRIVER', 'ON_THE_WAY', 'DELIVERED']),
        #         "estimated_delivery_time": lambda: fake.date_time_this_year(),
        #         "actual_delivery_time": lambda: fake.date_time_this_year(),
        #     },
        #     action=action
        # )
        # load_one_to_many_model(
        #     model_class=Delivery,
        #     primary_field='deliverer',
        #     primary_objects=map_queryset.get(Deliverer),
        #     max_related_count=max_deliveries_per_deliverer,
        #     oto_field='order',
        #     oto_field_objects=map_queryset.get(Order),
        #     attributes={
        #         "pickup_location": lambda: fake.address(),
        #         "pickup_latitude": generate_latitude,
        #         "pickup_longitude": generate_longitude,
        #         "dropoff_location": lambda: fake.address(),
        #         "dropoff_latitude": generate_latitude,
        #         "dropoff_longitude": generate_longitude,
        #         "status": lambda: random.choice(['FINDING_DRIVER', 'ON_THE_WAY', 'DELIVERED']),
        #         "estimated_delivery_time": lambda: fake.date_time_this_year(),
        #         "actual_delivery_time": lambda: fake.date_time_this_year(),
        #     },
        #     action=action
        # )

    if OrderPromotion in models_to_update:
        order_list = map_queryset.get(Order)
        promotion_list = map_queryset.get(Promotion)
        load_intermediate_model(
            model_class=OrderPromotion,
            primary_field='order',
            related_field='promotion',
            primary_objects=order_list,
            related_objects=promotion_list,
            max_items=max_promotions_per_order,
            action=action
        )

    if RestaurantPromotion in models_to_update:
        restaurant_list = list(Restaurant.objects.all())
        promotion_list = map_queryset.get(Promotion, [])
        load_intermediate_model(
            model_class=RestaurantPromotion,
            primary_field='restaurant',
            related_field='promotion',
            primary_objects=restaurant_list,
            related_objects=promotion_list,
            max_items=max_promotions_per_restaurant,
            action=action
        )

    if UserPromotion in models_to_update:
        user_list = list(User.objects.all())
        promotion_list = map_queryset.get(Promotion, [])
        load_intermediate_model(
            model_class=UserPromotion,
            primary_field='user',
            related_field='promotion',
            primary_objects=user_list,
            related_objects=promotion_list,
            max_items=max_promotions_per_user,
            action=action
        )


def run(*args):
    load_order(*args)
