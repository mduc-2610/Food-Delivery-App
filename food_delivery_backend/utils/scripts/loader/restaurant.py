import random
from faker import Faker

from account.models import User
from food.models import Dish
from restaurant.models import (
    BasicInfo, DetailInfo, MenuDelivery,
    Representative, OperatingHour, Restaurant
)

from utils.function import load_one_to_many_model

fake = Faker()

def generate_phone_number():
    return f"+84{random.randint(100000000, 99999999999)}"

def load_restaurant(
    max_restaurants=0,
    max_restaurant_dishes=20
):
    model_list = [
        BasicInfo, DetailInfo, MenuDelivery,
        Representative, OperatingHour, Restaurant
    ]
    
    for model in model_list:
        model.objects.all().delete()

    user_list = list(User.objects.all())
    dish_list = list(Dish.objects.all())
    
    print("________________________________________________________________")
    print("RESTAURANT:")
    restaurant_list = []
    for i, user in enumerate(user_list):
        if i >= max_restaurants: break

        restaurant_data = {
            "user": user,
            # "basic_info": basic_info,
            # "detail_info": detail_info,
            # "menu_delivery": menu_delivery,
            # "representative": representative,
        }
        restaurant = Restaurant.objects.create(**restaurant_data)
        restaurant_list.append(restaurant)
        print(f"\tSuccessfully created Restaurant: {restaurant}\n")

        basic_info_data = {
            "restaurant": restaurant,
            "name": fake.company(),
            "phone_number": generate_phone_number(),
            "city": fake.city(),
            "district": fake.state(),
            "street_address": fake.street_address(),
            "map_location": f"{fake.latitude()}, {fake.longitude()}"
        }
        basic_info = BasicInfo.objects.create(**basic_info_data)
        print(f"\tSuccessfully created Basic Info: {basic_info}")

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
            "restaurant_category": fake.word(),
            "purpose": fake.word()
        }
        detail_info = DetailInfo.objects.create(**detail_info_data)
        print(f"\tSuccessfully created Detail Info: {detail_info}")

        menu_delivery_data = {
            "restaurant": restaurant,
            "menu_image": fake.image_url()
        }
        menu_delivery = MenuDelivery.objects.create(**menu_delivery_data)
        print(f"\tSuccessfully created Menu Delivery: {menu_delivery}")

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
    
    print("________________________________________________________________")
    print("RESTAURANT DISH:")
    for restaurant in restaurant_list:
        tmp = dish_list.copy()
        for _ in range(random.randint(1, max_restaurant_dishes)):
            dish = tmp.pop(random.randint(0, len(tmp) - 1))
            dish.restaurant = restaurant
            dish.save()
            print(f"\tSuccessfully added Dish: {dish} to Restaurant: {restaurant}")

    return restaurant_list