import sys
from faker import Faker
import random
from django.db import transaction
from django.utils import timezone
from dateutil.relativedelta import relativedelta

from account.models import User
from deliverer.models import Deliverer
from restaurant.models import Restaurant
from food.models import Dish
from order.models import (
    RestaurantPromotion, 
    # ActivityPromotion, 
    # OrderPromotion, 
    # UserPromotion, 
    RestaurantPromotion, 
    Order, 
    Delivery, DeliveryRequest, RestaurantCart, RestaurantCartDish
)

from utils.function import (
    load_intermediate_model, 
    load_normal_model,
    load_one_to_many_model,
    generate_random_time_in_year,
    generate_latitude, 
    generate_longitude,
)
from utils.decorators import script_runner

fake = Faker()

MODEL_MAP = {
    'promotion': RestaurantPromotion,
    # 'activity_promotion': ActivityPromotion,
    # 'order_promotion': OrderPromotion,
    # 'user_promotion': UserPromotion,
    'restaurant_promotion': RestaurantPromotion,
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
    max_restaurant_carts_per_user=150,
    max_dishes_per_restaurant_cart=10,
    models_to_update=None,
    map_queryset=None,
    action=None,
):

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
        promotion_list = map_queryset.get(RestaurantPromotion)
        deliverers = map_queryset.get(Deliverer)
        print(promotion_list)
        for _cart in restaurant_cart_list:
            user_location = _cart.user.locations.filter(is_selected=True).first()
            # print(user_location, pretty=True)
            order_data = {
                "cart": _cart,
                "payment_method": random.choice(['CASH', 'CARD', 'PAYPAL']),
                "status": random.choice(['ACTIVE', 'CANCELLED', 'COMPLETED', 'PENDING']),
                "rating": random.randint(0, 5),
                'created_at': generate_random_time_in_year(),
            }
            order = Order.objects.create(**order_data)
            if order.status == 'ACTIVE':
                order.create_delivery_and_request()
            else:
                _restaurant = _cart.restaurant
                _user = _cart.user
                _delivery_address = order.delivery_address
                if not _delivery_address: continue
                if hasattr(_restaurant, 'basic_info'):
                    delivery, created_delivery = Delivery.objects.get_or_create(
                        order=order, 
                        user=_user,
                        restaurant=_restaurant,
                        deliverer=random.choice(deliverers),
                        defaults={
                            'pickup_location': _restaurant.basic_info.street_address,
                            'pickup_latitude': _restaurant.basic_info.latitude,
                            'pickup_longitude': _restaurant.basic_info.longitude,
                            'dropoff_location': _delivery_address.address,
                            'dropoff_latitude': _delivery_address.latitude,
                            'dropoff_longitude': _delivery_address.longitude,
                        }
                    )
            order_list.append(order)
            print(f"\tSuccessfully created Order: {order}")

    # if Delivery in models_to_update:
    #     deliverer_list = list(Deliverer.objects.all())
    #     order_list = map_queryset.get(Order).filter(status="COMPLETED")
    #     load_intermediate_model(
    #         model_class=Delivery,
    #         primary_field='order',
    #         related_field='deliverer',
    #         primary_objects=order_list,
    #         related_objects=deliverer_list,
    #         max_items=max_deliveries_per_deliverer,
    #         attributes={
    #             "pickup_location": lambda: fake.address(),
    #             "pickup_latitude": generate_latitude,
    #             "pickup_longitude": generate_longitude,
    #             "dropoff_location": lambda: fake.address(),
    #             "dropoff_latitude": generate_latitude,
    #             "dropoff_longitude": generate_longitude,
    #             "status": 'DELIVERED',
    #             "estimated_delivery_time": lambda: fake.date_time_this_year(),
    #             "actual_delivery_time": lambda: fake.date_time_this_year(),
    #         },
    #         action=action
    #     )
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

    # if OrderPromotion in models_to_update:
    #     order_list = map_queryset.get(Order)
    #     promotion_list = map_queryset.get(Promotion)
    #     load_intermediate_model(
    #         model_class=OrderPromotion,
    #         primary_field='order',
    #         related_field='promotion',
    #         primary_objects=order_list,
    #         related_objects=promotion_list,
    #         max_items=max_promotions_per_order,
    #         action=action
    #     )

    if RestaurantPromotion in models_to_update:
        restaurant_list = list(Restaurant.objects.all())
        def generate_interval_month_date_same_year(date_time=None, interval=1):
            current_date = date_time or timezone.now()
            year = current_date.year
            month = current_date.month

            start_date = current_date.replace(day=1)

            end_date = current_date.replace(day=1) + relativedelta(months=interval)

            return start_date, end_date
        
        load_one_to_many_model(
            model_class=RestaurantPromotion,
            primary_field='restaurant',
            primary_objects=restaurant_list,
            max_related_count=max_promotions_per_restaurant,
            attributes={
                "name": lambda: fake.unique.text(max_nb_chars=100),
                "code": lambda: fake.unique.text(max_nb_chars=10).upper(),
                "promo_type": lambda: random.choice(['SHIPPING', 'ORDER']),
                "discount_percentage": lambda: fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
                "discount_amount": lambda: fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
                "start_date": lambda: generate_interval_month_date_same_year()[0],
                "end_date": lambda: generate_interval_month_date_same_year()[1],
                "applicable_price": lambda: fake.pydecimal(left_digits=8, right_digits=2, positive=True, min_value=10, max_value=1000),
                "description": lambda: fake.text(max_nb_chars=200),
                "terms_and_conditions": lambda: fake.text(max_nb_chars=200),
            },
            action=action
        )

    # if UserPromotion in models_to_update:
    #     user_list = list(User.objects.all())
    #     promotion_list = map_queryset.get(Promotion, [])
    #     load_intermediate_model(
    #         model_class=UserPromotion,
    #         primary_field='user',
    #         related_field='promotion',
    #         primary_objects=user_list,
    #         related_objects=promotion_list,
    #         max_items=max_promotions_per_user,
    #         action=action
    #     )


def run(*args):
    load_order(*args)
