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
    Delivery, RestaurantCart, RestaurantCartDish
)

from utils.function import (
    load_intermediate_model, 
    generate_latitude, generate_longitude
)

fake = Faker()

MODEL_MAP = {
    'promotion': Promotion,
    'activity_promotion': ActivityPromotion,
    'order_promotion': OrderPromotion,
    'restaurant_promotion': RestaurantPromotion,
    'user_promotion': UserPromotion,
    'order': Order,
    'delivery': Delivery,
    'restaurant_cart': RestaurantCart,
    'restaurant_cart_dish': RestaurantCartDish,
}

@transaction.atomic
def load_order(
    max_promotions=200, 
    max_order_promotions=30, 
    max_restaurant_promotions=50, 
    max_user_promotions=40,
    max_deliveries=100,
    max_restaurants_per_cart=7,
    max_restaurant_cart_dishes=10,
    models_to_update=None
):
    all_objects = {model: model.objects.all() for model in MODEL_MAP.values()}

    if models_to_update is None or models_to_update:
        if models_to_update:
            models_to_update_classes = [MODEL_MAP[m] for m in models_to_update if m in MODEL_MAP]
        else:
            models_to_update_classes = MODEL_MAP.values()

        if Promotion in models_to_update_classes:
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

        if RestaurantCart in models_to_update_classes:
            user_list = list(User.objects.all())
            restaurant_list = list(Restaurant.objects.all())
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
                    "is_created_order": True,
                }
            )

        if RestaurantCartDish in models_to_update_classes:
            print("________________________________________________________________")
            print("RESTAURANT CART DISHES:")
            dish_list = list(Dish.objects.all())
            restaurant_cart_list = all_objects.get(RestaurantCart, [])
            load_intermediate_model(
                model_class=RestaurantCartDish,
                primary_field='cart',
                related_field='dish',
                primary_objects=restaurant_cart_list,
                related_objects=dish_list,
                max_items=max_restaurant_cart_dishes,
                attributes={
                    "quantity": lambda: fake.random_int(min=1, max=5),
                }
            )

        if Order in models_to_update_classes:
            print("________________________________________________________________")
            print("ORDERS:")
            order_list = []
            restaurant_cart_list = all_objects.get(RestaurantCart, [])
            promotion_list = all_objects.get(Promotion, [])
            for _cart in restaurant_cart_list:
                order_data = {
                    "cart": _cart,
                    "payment_method": fake.random_element(elements=('Credit Card', 'Paypal', 'Cash on Delivery')),
                    "promotion": random.choice(promotion_list) if random.choice([True, False]) else None,
                    "discount": random.uniform(0, 10),
                    "status": fake.random_element(elements=['ACTIVE', 'CANCELLED', 'COMPLETED', 'PENDING']),
                    "rating": random.randint(0, 5)
                }
                order = Order.objects.create(**order_data)
                order_list.append(order)
                print(f"\tSuccessfully created Order: {order}")

        if Delivery in models_to_update_classes:
            deliverer_list = list(Deliverer.objects.all())
            order_list = all_objects.get(Order, [])
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
                    "pickup_latitude": generate_latitude(),
                    "pickup_longitude": generate_longitude(),
                    "dropoff_location": fake.address,
                    "dropoff_latitude": generate_latitude(),
                    "dropoff_longitude": generate_longitude(),
                    "status": lambda: random.choice(['FINDING_DRIVER', 'ON_THE_WAY', 'DELIVERED']),
                    "estimated_delivery_time": fake.date_time_this_year,
                    "actual_delivery_time": fake.date_time_this_year
                }
            )

        if OrderPromotion in models_to_update_classes:
            print("________________________________________________________________")
            print("ORDER PROMOTIONS:")
            order_list = all_objects.get(Order, [])
            promotion_list = all_objects.get(Promotion, [])
            load_intermediate_model(
                model_class=OrderPromotion,
                primary_field='order',
                related_field='promotion',
                primary_objects=order_list,
                related_objects=promotion_list,
                max_items=max_order_promotions
            )

        if RestaurantPromotion in models_to_update_classes:
            restaurant_list = list(Restaurant.objects.all())
            promotion_list = all_objects.get(Promotion, [])
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

        if UserPromotion in models_to_update_classes:
            user_list = list(User.objects.all())
            promotion_list = all_objects.get(Promotion, [])
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
        load_order(models_to_update=models_to_update)
    elif action not in ['delete', 'update']:
        print("Invalid action. Use 'delete' or 'update'.")
