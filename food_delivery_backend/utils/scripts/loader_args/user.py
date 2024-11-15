import random
from faker import Faker
from datetime import timedelta

from django.utils import timezone
from django.db import transaction
from django.contrib.auth.hashers import make_password

from account.models import (
    User, OTP,
    Profile, UserLocation, 
    Setting, SecuritySetting 
)
from utils.function import generate_latitude, generate_longitude, generate_phone_number
from utils.decorators import script_runner

fake = Faker()

MODEL_MAP = {
    'user': User,
    'otp': OTP,
    'profile': Profile,
    'user_location': UserLocation,
    'setting': Setting,
    'security_setting': SecuritySetting
}

@script_runner(MODEL_MAP)
@transaction.atomic
def load_user(
    max_users=5000,
    models_to_update=None,
    map_queryset=None,
    action=None,
):
    if models_to_update is None:
        models_to_update = MODEL_MAP.keys()

    if User in models_to_update:
        User.objects.all().delete()  

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
                UserLocation.objects.create(**location_data)
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

def run(*args):
    load_user(*args)