import random
from faker import Faker
from datetime import datetime, timedelta

from restaurant.models import (
    BasicInfo, DetailInformation, MenuDelivery,
    Representative, OperatingHour, Restaurant
)

fake = Faker()

def generate_phone_number():
    return f"+84{random.randint(100000000, 99999999999)}"

def load_restaurant(MAX_NUMBER_RESTAURANTS, user_list):
    model_list = [
        BasicInfo, DetailInformation, MenuDelivery,
        Representative, OperatingHour, Restaurant
    ]
    
    for model in model_list:
        model.objects.all().delete()

    print("________________________________________________________________")
    print("RESTAURANT:")
    restaurant_list = []
    for i, user in enumerate(user_list):
        if i >= MAX_NUMBER_RESTAURANTS: break

        basic_info_data = {
            "name": fake.company(),
            "phone_number": generate_phone_number(),
            "city": fake.city(),
            "district": fake.state(),
            "street_address": fake.street_address(),
            "map_location": f"{fake.latitude()}, {fake.longitude()}"
        }
        basic_info = BasicInfo.objects.create(**basic_info_data)
        print(f"\tSuccessfully created Basic Info: {basic_info}")

        detail_information_data = {
            "opening_hours": {"Monday": "9:00-22:00", "Tuesday": "9:00-22:00", "Wednesday": "9:00-22:00", "Thursday": "9:00-22:00", "Friday": "9:00-23:00", "Saturday": "9:00-23:00", "Sunday": "9:00-22:00"},
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
        detail_information = DetailInformation.objects.create(**detail_information_data)
        print(f"\tSuccessfully created Detail Information: {detail_information}")

        menu_delivery_data = {
            "menu_image": fake.image_url()
        }
        menu_delivery = MenuDelivery.objects.create(**menu_delivery_data)
        print(f"\tSuccessfully created Menu Delivery: {menu_delivery}")

        representative_data = {
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
                "detail_information": detail_information,
                "day_of_week": day,
                "open_time": fake.time_object(),
                "close_time": fake.time_object()
            }
            OperatingHour.objects.create(**operating_hour_data)
            print(f"\tSuccessfully created Operating Hour for {detail_information} on {day}")

        restaurant_data = {
            "user": user,
            "basic_info": basic_info,
            "detail_information": detail_information,
            "menu_delivery": menu_delivery,
            "representative": representative,
        }
        restaurant = Restaurant.objects.create(**restaurant_data)
        restaurant_list.append(restaurant)
        print(f"\tSuccessfully created Restaurant: {restaurant}\n")
    
    return restaurant_list