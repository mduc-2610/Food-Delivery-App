import random
from faker import Faker
from datetime import timedelta

from django.utils import timezone
from django.db import transaction
from django.contrib.auth.hashers import make_password

from account.models import (
    User, OTP,
    Profile, Location, 
    Setting, SecuritySetting 
)
from utils.function import generate_latitude, generate_longitude

fake = Faker()

MODEL_MAP = {
    'user': User,
    'otp': OTP,
    'profile': Profile,
    'location': Location,
    'setting': Setting,
    'security_setting': SecuritySetting
}

def generate_phone_number():
    return f"+84{random.randint(100000000, 9999999999)}"

@transaction.atomic
def load_user(max_users=100, models_to_update=None):
    all_objects = {model: model.objects.all() for model in MODEL_MAP.values()}

    if models_to_update is None or any(model in models_to_update for model in MODEL_MAP.keys()):
        for model in MODEL_MAP.values():
            if models_to_update is None or model.__name__.lower() in models_to_update:
                model.objects.all().delete()

        print("________________________________________________________________")
        print("USER:")
        
        superuser = User.objects.create_superuser(phone_number="+84858189111", password="Duckkucd.123")
        print(f"Superuser created: {superuser}")

        user_list = []
        for _ in range(max_users):
            user_data = {
                "phone_number": generate_phone_number(),
                "password": make_password("Duckkucd.123"),
                "email": fake.name().split()[0].lower() + fake.email(),
                "is_registration_verified": True,
            }
            user = User.objects.create(**user_data)
            user_list.append(user)
            print(f"\tSuccessfully created User: {user}")

            otp_data = {
                "user": user,
                "code": f"{random.randint(1000, 9999)}",
                "expired_at": timezone.now() + timedelta(seconds=60)
            }
            OTP.objects.create(**otp_data)
            print(f"\tSuccessfully created OTP for User: {user}")
            
            number_location = random.randint(1, 5)
            selected_index = random.randint(0, number_location - 1)
            for i in range(number_location):
                location_data = {
                    "user": user,
                    "name": fake.word(),
                    "address": fake.address(),
                    "latitude": generate_latitude(),
                    "longitude": generate_longitude(),
                    "is_selected": i == selected_index,
                }
                Location.objects.create(**location_data)
                print(f"\tSuccessfully created Location for User: {user}")

            profile_data = {
                "user": user,
                "name": fake.name(),
                "gender": fake.random_element(elements=("MALE", "FEMALE")),
                "date_of_birth": fake.date_of_birth(tzinfo=timezone.get_current_timezone())
            }
            Profile.objects.create(**profile_data)
            print(f"\tSuccessfully created Profile for User: {user}")

            setting_data = {
                "user": user,
                "notification": fake.boolean(),
                "dark_mode": fake.boolean(),
                "sound": fake.boolean(),
                "automatically_updated": fake.boolean(),
                "language": fake.random_element(elements=["ENGLISH", "Vietnamese"]),
            }
            Setting.objects.create(**setting_data)
            print(f"\tSuccessfully created Setting for User: {user}")

            security_setting_data = {
                "setting": user.setting,
                "face_id": fake.boolean(),
                "touch_id": fake.boolean(),
                "pin_security": fake.boolean(),
            }
            SecuritySetting.objects.create(**security_setting_data)
            print(f"\tSuccessfully created Security Setting for User: {user}\n")
    
    return user_list

def delete_models(models_to_delete):
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
        load_user(models_to_update=models_to_update)
    else:
        print("Invalid action. Use 'delete' or 'update'.")

