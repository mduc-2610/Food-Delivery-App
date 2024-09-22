import random
from faker import Faker
from django.db import transaction

from account.models import User
from food.models import Dish, DishCategory
from restaurant.models import (
    BasicInfo, 
    DetailInfo, 
    PaymentInfo,
    MenuDelivery,
    RepresentativeInfo, 
    OperatingHour, 
    Restaurant, 
    RestaurantCategory
)
from utils.function import (
    load_intermediate_model, 
    load_one_to_many_model,
    load_normal_model,
    generate_latitude, 
    generate_longitude, 
)
from utils.decorators import script_runner
from utils.function import generate_phone_number, update_attr

fake = Faker()

MODEL_MAP = {
    'basic_info': BasicInfo,
    'detail_info': DetailInfo,
    'menu_delivery': MenuDelivery,
    'representative_info': RepresentativeInfo,
    'operating_hour': OperatingHour,
    'restaurant': Restaurant,
    'restaurant_category': RestaurantCategory,
    'payment_info': PaymentInfo,
}

@script_runner(MODEL_MAP)
@transaction.atomic
def load_restaurant(
    max_restaurants=50,
    max_restaurant_category_dishes=8,
    max_categories_per_restaurant=3,
    models_to_update=None,
    map_queryset=None,
    action=None,
):
    if Restaurant in models_to_update:
        user_list = list(map_queryset.get(User))
        restaurant_list = load_normal_model(
            model_class=Restaurant,
            max_items=max_restaurants,
            attributes={"user": lambda: user_list.pop(random.randint(0, len(user_list) - 1))} if action == "delete" else {},
            action=action
        )    

    if BasicInfo in models_to_update:
        for restaurant in map_queryset.get(Restaurant):
            basic_info_data = {
                "name": fake.company(),
                "phone_number": generate_phone_number(),
                "city": fake.city(),
                "district": fake.state(),
                "street_address": fake.street_address(),
                "latitude": generate_latitude(),
                "longitude": generate_longitude(),
            }
            basic_info = None
            if action == "delete":
                basic_info_data.update({
                    'restaurant': restaurant
                })    
                basic_info = BasicInfo.objects.create(**basic_info_data)
            else:
                basic_info = BasicInfo.objects.get(restaurant__id=restaurant.id)
                basic_info = update_attr(basic_info, **basic_info_data)
            print(f"\tSuccessfully created Basic Info: {basic_info}")

    if DetailInfo in models_to_update:
        for restaurant in map_queryset.get(Restaurant):
            detail_info_data = {
                "keywords": ", ".join(fake.words(nb=5, unique=True)),
                "description": fake.text(max_nb_chars=200),
                "avatar_image": fake.image_url(),
                "cover_image": fake.image_url(),
                "facade_image": fake.image_url(),
                "restaurant_type": fake.word(),
                "cuisine": fake.word(),
                "specialty_dishes": ", ".join(fake.words(nb=3, unique=True)),
                "serving_times": fake.time(),
                "target_audience": ", ".join(fake.words(nb=3, unique=True)),
                "purpose": fake.word()
            }
            detail_info = None
            if action == "delete":
                detail_info_data.update({
                    'restaurant': restaurant
                })
                detail_info = DetailInfo.objects.create(**detail_info_data)
            else:
                detail_info = DetailInfo.objects.get(restaurant__id=restaurant.id)
                detail_info = update_attr(detail_info, **detail_info_data)
            print(f"\tSuccessfully created Detail Info: {detail_info}")

            if OperatingHour in models_to_update:
                days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
                for day in days_of_week:
                    operating_hour_data = {
                        "detail_info": detail_info,
                        "day_of_week": day,
                        "open_time": fake.time_object(),
                        "close_time": fake.time_object()
                    }
                    OperatingHour.objects.create(**operating_hour_data)
                    print(f"\tSuccessfully created Operating Hour for {detail_info} on {day}")

    if MenuDelivery in models_to_update:
        for restaurant in map_queryset.get(Restaurant):
            menu_delivery_data = {
                "menu_image": fake.image_url()
            }
            menu_delivery = None
            if action == "delete":
                menu_delivery_data.update({
                    'restaurant': restaurant
                })    
                menu_delivery = MenuDelivery.objects.create(**menu_delivery_data)
            else:
                menu_delivery = MenuDelivery.objects.get(restaurant__id=restaurant.id)
                menu_delivery = update_attr(menu_delivery, ** menu_delivery_data)
            print(f"\tSuccessfully created Menu Delivery: {menu_delivery}")

    if RepresentativeInfo in models_to_update:
        for restaurant in map_queryset.get(Restaurant):
            representative_data = {
                "registration_type": fake.random_element(elements=('INDIVIDUAL', 'RESTAURANT_CHAIN')),
                "full_name": fake.name(),
                "email": fake.email(),
                "phone_number": generate_phone_number(),
                "other_phone_number": generate_phone_number(),
                "tax_code": str(fake.random_int(min=100000, max=9999999)),
                "citizen_identification": str(fake.random_int(min=1000000000, max=9999999999)),
                "citizen_identification_front": fake.image_url(),
                "citizen_identification_back": fake.image_url(),
                "business_registration_image": fake.image_url()
            }
            representative = None
            if action == "delete":
                representative_data.update({
                    'restaurant': restaurant
                })
                representative = RepresentativeInfo.objects.create(**representative_data)
            else:
                representative = RepresentativeInfo.objects.get(restaurant__id=restaurant.id)
                representative = update_attr(representative, ** representative_data)
            print(f"\tSuccessfully created Representative: {representative}")
    
    if PaymentInfo in models_to_update:
        for restaurant in map_queryset.get(Restaurant):
            payment_info_data = {
                "email": fake.email(),
                "phone_number": generate_phone_number(),
                "citizen_identification": fake.unique.random_number(digits=12, fix_len=True),
                "account_name": restaurant.basic_info.name if hasattr(restaurant, 'basic_info') else fake.company(),  
                "account_number": str(fake.unique.random_number(digits=10)),
                "bank": fake.company(),  
                "city": restaurant.basic_info.city if hasattr(restaurant, 'basic_info') else fake.city(),
                "branch": fake.street_name()  
            }

            payment_info = None
            if action == "delete":
                payment_info_data.update({
                    'restaurant': restaurant
                })
                payment_info = PaymentInfo.objects.create(**payment_info_data)
            else:
                payment_info = PaymentInfo.objects.get(restaurant__id=restaurant.id)
                payment_info = update_attr(payment_info, **payment_info_data)
            print(f"\tSuccessfully created/updated Payment Info: {payment_info}")

    if RestaurantCategory in models_to_update:
        load_intermediate_model(
            model_class=RestaurantCategory,
            primary_field='restaurant',
            related_field='category',
            primary_objects=map_queryset.get(Restaurant),
            related_objects=list(DishCategory.objects.all()),
            max_items=max_categories_per_restaurant,
            action=action
        )

    # if Dish in models_to_update:
        for restaurant in map_queryset.get(Restaurant):
            for category in restaurant.categories.all():
                tmp = list(category.dishes.all())
                for _ in range(random.randint(1, max_restaurant_category_dishes)):
                    if not tmp:
                        break
                    max_loop = 100
                    dish = random.choice(tmp)
                    while dish.restaurant is None and max_loop:
                        dish.restaurant = restaurant                
                        dish = random.choice(tmp)
                        max_loop -= 1
                    dish.save()
                    print(f"\tSuccessfully added Dish: {dish} to Restaurant: {restaurant}")
def run(*args):
    load_restaurant(*args)