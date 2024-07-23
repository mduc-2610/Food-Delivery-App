from faker import Faker
import random

from account.models import User
from deliverer.models import Deliverer
from restaurant.models import Restaurant
from food.models import Dish
from order.models import (
    Promotion, ActivityPromotion, OrderPromotion, 
    RestaurantPromotion, UserPromotion, Order, 
    Delivery, Cart, RestaurantCart, RestaurantCartDish
)

from utils.function import load_intermediate_model

fake = Faker()

def generate_phone_number():
    return f"+84{random.randint(100000000, 999999999)}"

def load_order(
    max_promotions=0, max_order_promotions=0, max_restaurant_promotions=0, max_user_promotions=0,
    max_orders=0, max_deliveries=0,
    max_carts=0, max_dishes=0
):
    model_list = [
        Promotion, ActivityPromotion, OrderPromotion, 
        RestaurantPromotion, UserPromotion, Order, 
        Delivery, Cart, RestaurantCart, RestaurantCartDish
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
    print("CARTS:")
    cart_list = []
    for user in user_list:
        cart = Cart.objects.create(user=user)
        print(f"\tSuccessfully created Cart: {cart}")
        cart_list.append(cart)

    print("________________________________________________________________")
    print("RESTAURANT CARTS:")
    restaurant_cart_list = []
    for _ in range(max_carts):
        restaurant_cart_data = {
            "cart": random.choice(cart_list),
            "restaurant": random.choice(restaurant_list),
            "is_placed_order": fake.boolean(),
            "raw_fee": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=10, max_value=100)
        }
        restaurant_cart = RestaurantCart.objects.create(**restaurant_cart_data)
        restaurant_cart_list.append(restaurant_cart)
        print(f"\tSuccessfully created Restaurant Cart: {restaurant_cart}")

    print("________________________________________________________________")
    print("RESTAURANT CART DISHES:")
    for _ in range(max_dishes):
        restaurant_cart_dish_data = {
            "cart": random.choice(restaurant_cart_list),
            "dish": random.choice(dish_list),
            "quantity": fake.random_int(min=1, max=5),
            "price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50)
        }
        restaurant_cart_dish = RestaurantCartDish.objects.create(**restaurant_cart_dish_data)
        print(f"\tSuccessfully created Restaurant Cart Dish: {restaurant_cart_dish}")

    print("________________________________________________________________")
    print("ORDERS:")
    order_list = []
    tmp_cart = restaurant_cart_list
    for _ in range(max_orders):
        order_data = {
            "cart": tmp_cart.pop(random.randint(0, len(tmp_cart) - 1)),
            "delivery_address": fake.address(),
            "payment_method": fake.random_element(elements=('Credit Card', 'Paypal', 'Cash on Delivery')),
            "promotion": random.choice(promotion_list) if random.choice([True, False]) else None,
            "delivery_fee":  random.uniform(0, 10), 
            "discount":  random.uniform(0, 10),
            "total":  random.uniform(0, 10),
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

