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
    Delivery, RestaurantCart, RestaurantCartDish
)

from utils.function import load_intermediate_model

fake = Faker()

def generate_phone_number():
    return f"+84{random.randint(100000000, 999999999)}"

@transaction.atomic
def load_order(
    max_promotions=200, 
    max_order_promotions=30, 
    max_restaurant_promotions=50, 
    max_user_promotions=40,
    max_deliveries=100,
    max_restaurants_per_cart=7,
    max_restaurant_cart_dishes=10
):
    model_list = [
        Promotion, ActivityPromotion, OrderPromotion, 
        RestaurantPromotion, UserPromotion, Order, 
        Delivery, RestaurantCart, RestaurantCartDish
    ]
    
    user_list = list(User.objects.all())
    restaurant_list = list(Restaurant.objects.all())
    deliverer_list = list(Deliverer.objects.all())
    dish_list = list(Dish.objects.all())

    for model in model_list:
        model.objects.all().delete()

    print("________________________________________________________________")
    print("PROMOTIONS:")
    promotion_list = []
    for _ in range(max_promotions):
        promo_data = {
            "code": fake.unique.text(max_nb_chars=10).upper(),
            "description": fake.text(max_nb_chars=200),
            "promo_type": random.choice(['SHIPPING', 'ORDER', 'ACTIVITY']),
            "discount_percentage": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
            "discount_amount": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
            "start_date": fake.date_time_this_year(),
            "end_date": fake.date_time_this_year(),
            "applicable_scope": fake.text(max_nb_chars=50),
            "terms_and_conditions": fake.text(max_nb_chars=200),
            "active": fake.boolean()
        }
        promotion = Promotion.objects.create(**promo_data)
        promotion_list.append(promotion)
        print(f"\tSuccessfully created Promotion: {promotion}")

    print("________________________________________________________________")
    print("RESTAURANT CARTS:")
    restaurant_cart_list = load_intermediate_model(
        model_class=RestaurantCart,
        primary_field='user',
        related_field='restaurant',
        primary_objects=user_list,
        related_objects=restaurant_list,
        max_items=max_restaurants_per_cart,
        min_items=1,
        attributes={
            "is_placed_order": fake.boolean,
            "raw_fee": lambda: fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=10, max_value=100)
        }
    )

    print("________________________________________________________________")
    print("RESTAURANT CART DISHES:")
    load_intermediate_model(
        model_class=RestaurantCartDish,
        primary_field='cart',
        related_field='dish',
        primary_objects=restaurant_cart_list,
        max_items=max_restaurant_cart_dishes,
        attributes={
            "quantity": lambda: fake.random_int(min=1, max=5),
        },
        query_attributes=['restaurant', 'dishes'],
    )

    print("________________________________________________________________")
    print("ORDERS:")
    order_list = []
    for _cart in restaurant_cart_list:
        user_location = list(_cart.user.locations.all()).copy()
        print(user_location, pretty=True)
        order_data = {
            "cart": _cart,
            "delivery_address": random.choice(user_location) if user_location else None,
            "payment_method": fake.random_element(elements=('Credit Card', 'Paypal', 'Cash on Delivery')),
            "promotion": random.choice(promotion_list) if random.choice([True, False]) else None,
            "delivery_fee":  random.uniform(0, 10), 
            "discount":  random.uniform(0, 10),
            "status": fake.random_element(elements=['ACTIVE', 'CANCELLED', 'COMPLETED', 'PENDING']),
        }
        order = Order.objects.create(**order_data)
        order_list.append(order)
        print(f"\tSuccessfully created Order: {order}")

    print("________________________________________________________________")
    print("DELIVERIES:")
    load_intermediate_model(
        model_class=Delivery,
        primary_field='order',
        related_field='deliverer',
        primary_objects=order_list,
        related_objects=deliverer_list,
        max_items=max_deliveries,
        attributes={
            "pickup_location": fake.address,
            "pickup_lat": fake.latitude,
            "pickup_long": fake.longitude,
            "dropoff_location": fake.address,
            "dropoff_lat": fake.latitude,
            "dropoff_long": fake.longitude,
            "status": lambda: random.choice(['FINDING_DRIVER', 'ON_THE_WAY', 'DELIVERED']),
            "estimated_delivery_time": fake.date_time_this_year,
            "actual_delivery_time": fake.date_time_this_year
        }
    )

    print("________________________________________________________________")
    print("ORDER PROMOTIONS:")
    load_intermediate_model(
        model_class=OrderPromotion,
        primary_field='order',
        related_field='promotion',
        primary_objects=order_list,
        related_objects=promotion_list,
        max_items=max_order_promotions
    )

    print("________________________________________________________________")
    print("RESTAURANT PROMOTIONS:")
    load_intermediate_model(
        model_class=RestaurantPromotion,
        primary_field='restaurant',
        related_field='promotion',
        primary_objects=restaurant_list,
        related_objects=promotion_list,
        max_items=max_restaurant_promotions
    )

    print("________________________________________________________________")
    print("USER PROMOTIONS:")
    load_intermediate_model(
        model_class=UserPromotion,
        primary_field='user',
        related_field='promotion',
        primary_objects=user_list,
        related_objects=promotion_list,
        max_items=max_user_promotions
    )

    return promotion_list, order_list, restaurant_cart_list


def run():
    load_order()