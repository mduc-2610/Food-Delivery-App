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
    RestaurantCategory,
    RestaurantLike,
)
from utils.function import (
    load_intermediate_model, 
    load_one_to_many_model,
    load_normal_model,
    generate_latitude, 
    generate_longitude, 
)
from utils.decorators import script_runner
from utils.function import (
    generate_phone_number,
    update_attr,
)
from utils.scripts.data import vietnam_location_data

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
    'restaurant_like': RestaurantLike,
}

# Generate function for models with 'city' and 'district' attributes
def generate_location_attributes():
    location = random.choice(vietnam_location_data)
    city = location["name"]
    district_data = random.choice(location["districts"])
    district = district_data["name"]
    return city, district

@script_runner(MODEL_MAP)
@transaction.atomic
def load_restaurant(
    max_restaurants=50,
    max_dishes_per_category=8,
    max_likes_per_restaurant=30,
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
            attributes=lambda: {"user": user_list.pop(random.randint(0, len(user_list) - 1))} if action == "delete" else {},
            action=action
        )    

    if BasicInfo in models_to_update:
        def generate_basic_info_attributes():
            city, district = generate_location_attributes()
            return {
                "name": fake.company(),
                "phone_number": generate_phone_number(),
                "city": city,
                "district": district,
                "address": fake.street_address(),
                "latitude": generate_latitude(),
                "longitude": generate_longitude(),
            }

        load_normal_model(
            model_class=BasicInfo,
            max_items=max_restaurants,
            oto_field="restaurant",
            oto_objects=map_queryset.get(Restaurant),
            attributes=generate_basic_info_attributes,
            action=action
        )

    if DetailInfo in models_to_update:
        load_normal_model(
            model_class=DetailInfo,
            max_items=max_restaurants,
            oto_field="restaurant",
            oto_objects=map_queryset.get(Restaurant),
            attributes=lambda: {
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
            },
            action=action
        )

    if MenuDelivery in models_to_update:
        load_normal_model(
            model_class=MenuDelivery,
            max_items=max_restaurants,
            oto_field="restaurant",
            oto_objects=map_queryset.get(Restaurant),
            attributes=lambda: {"menu_image": fake.image_url()},
            action=action
        )

    if RepresentativeInfo in models_to_update:
        load_normal_model(
            model_class=RepresentativeInfo,
            max_items=max_restaurants,
            oto_field="restaurant",
            oto_objects=map_queryset.get(Restaurant),
            attributes=lambda: {
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
            },
            action=action
        )

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
                try:
                    payment_info = PaymentInfo.objects.get(restaurant__id=restaurant.id)
                    payment_info = update_attr(payment_info, **payment_info_data)
                    print(f"\tSuccessfully created/updated Payment Info: {payment_info}")
                except:
                    continue
                
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

    if RestaurantLike in models_to_update:
        load_intermediate_model(
            model_class=RestaurantLike,
            primary_field='restaurant',
            related_field='user',
            primary_objects=map_queryset.get(Restaurant),
            related_objects=list(User.objects.all()),
            max_items=max_likes_per_restaurant,
            action=action
        )

def run(*args):
    load_restaurant(*args)
