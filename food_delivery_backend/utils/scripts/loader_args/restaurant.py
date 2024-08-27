import random
from faker import Faker
from django.db import transaction

from account.models import User
from food.models import Dish, DishCategory
from restaurant.models import (
    BasicInfo, DetailInfo, MenuDelivery,
    Representative, OperatingHour, Restaurant, RestaurantCategory
)
from utils.function import (
    load_intermediate_model, generate_latitude, generate_longitude
)

fake = Faker()

MODEL_MAP = {
    'basic_info': BasicInfo,
    'detail_info': DetailInfo,
    'menu_delivery': MenuDelivery,
    'representative': Representative,
    'operating_hour': OperatingHour,
    'restaurant': Restaurant,
    'restaurant_category': RestaurantCategory
}

def generate_phone_number():
    return f"+84{random.randint(100000000, 99999999999)}"

@transaction.atomic
def load_restaurant(
    max_restaurants=50,
    max_restaurant_category_dishes=8,
    max_restaurant_categories=3,
    models_to_update=None
):
    all_objects = {model: model.objects.all() for model in MODEL_MAP.values()}

    if models_to_update is None or any(model in models_to_update for model in MODEL_MAP.keys()):
        for model_name, model_class in MODEL_MAP.items():
            if models_to_update is None or model_name in models_to_update:
                model_class.objects.all().delete()

        user_list = list(User.objects.all())
        dish_list = list(Dish.objects.all())
        category_list = list(DishCategory.objects.all())
        
        if 'restaurant' in models_to_update or models_to_update is None:
            print("________________________________________________________________")
            print("RESTAURANTS:")
            restaurant_list = []
            for i, user in enumerate(user_list):
                if i >= max_restaurants:
                    break

                restaurant_data = {
                    "user": user,
                }
                restaurant = Restaurant.objects.create(**restaurant_data)
                restaurant_list.append(restaurant)
                print(f"\tSuccessfully created Restaurant: {restaurant}\n")

                if 'basic_info' in models_to_update or models_to_update is None:
                    basic_info_data = {
                        "restaurant": restaurant,
                        "name": fake.company(),
                        "phone_number": generate_phone_number(),
                        "city": fake.city(),
                        "district": fake.state(),
                        "street_address": fake.street_address(),
                        "latitude": generate_latitude(),
                        "longitude": generate_longitude(),
                    }
                    basic_info = BasicInfo.objects.create(**basic_info_data)
                    print(f"\tSuccessfully created Basic Info: {basic_info}")

                if 'detail_info' in models_to_update or models_to_update is None:
                    detail_info_data = {
                        "restaurant": restaurant,
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
                    detail_info = DetailInfo.objects.create(**detail_info_data)
                    print(f"\tSuccessfully created Detail Info: {detail_info}")

                if 'menu_delivery' in models_to_update or models_to_update is None:
                    menu_delivery_data = {
                        "restaurant": restaurant,
                        "menu_image": fake.image_url()
                    }
                    menu_delivery = MenuDelivery.objects.create(**menu_delivery_data)
                    print(f"\tSuccessfully created Menu Delivery: {menu_delivery}")

                if 'representative' in models_to_update or models_to_update is None:
                    representative_data = {
                        "restaurant": restaurant,
                        "registration_type": fake.random_element(elements=('Cá nhân', 'Công ty/Chuỗi')),
                        "full_name": fake.name(),
                        "email": fake.email(),
                        "phone_number": generate_phone_number(),
                        "other_phone_number": generate_phone_number(),
                        "id_front_image": fake.image_url(),
                        "id_back_image": fake.image_url(),
                        "business_registration_image": fake.image_url()
                    }
                    representative = Representative.objects.create(**representative_data)
                    print(f"\tSuccessfully created Representative: {representative}")

                if 'operating_hour' in models_to_update or models_to_update is None:
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

        if 'restaurant_category' in models_to_update or models_to_update is None:
            print("________________________________________________________________")
            print("RESTAURANT CATEGORIES:")
            load_intermediate_model(
                model_class=RestaurantCategory,
                primary_field='restaurant',
                related_field='category',
                primary_objects=restaurant_list,
                related_objects=category_list,
                max_items=max_restaurant_categories,
            )

        # Create Restaurant Dishes
        if 'dish' in models_to_update or models_to_update is None:
            print("________________________________________________________________")
            print("RESTAURANT DISHES:")
            for restaurant in restaurant_list:
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

def delete_models(models_to_delete):
    """
    Deletes all records from specified models.
    """
    for model_name in models_to_delete:
        model = MODEL_MAP.get(model_name)
        if model:
            model.objects.all().delete()
        else:
            print(f"Model '{model_name}' does not exist.")

def run(*args):
    action = args[0] if args else None
    models_to_update = args[1:] if len(args) > 1 else None

    if action == 'delete':
        models_to_delete = models_to_update if models_to_update else MODEL_MAP.keys()
        delete_models(models_to_delete)
    elif action == 'update':
        load_restaurant(models_to_update=models_to_update)
    else:
        print("Invalid action. Use 'delete' or 'update'.")

