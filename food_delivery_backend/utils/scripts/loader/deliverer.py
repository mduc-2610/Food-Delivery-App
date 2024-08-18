import random
from faker import Faker

from django.contrib.auth.hashers import make_password
from django.db import transaction

from account.models import User
from deliverer.models import (
    Address, BasicInfo, DriverLicense, EmergencyContact, 
    OperationInfo, OtherInfo, ResidencyInfo, Deliverer
)

fake = Faker()

@transaction.atomic
def generate_phone_number():
    return f"+84{random.randint(100000000, 999999999)}"

def load_deliverer(
    max_deliverers=40
):
    model_list = [
        Address, BasicInfo, DriverLicense, 
        EmergencyContact, OperationInfo, OtherInfo, 
        ResidencyInfo, Deliverer
    ]
    
    for model in model_list:
        model.objects.all().delete()

    user_list = list(User.objects.all())

    print("________________________________________________________________")
    print("DELIVERER:")
    deliverer_list = []
    for i, user in enumerate(user_list):
        if i >= max_deliverers: break
        
        deliverer_data = {
            "user": user,
            # "basic_info": basic_info,
            # "residency_info": residency_info,
            # "driver_license_and_vehicle": driver_license,
            # "other_info": other_info,
            # "address": address,
            # "operation_info": operation_info,
            # "emergency_contact": emergency_contact
        }
        deliverer = Deliverer.objects.create(**deliverer_data)
        deliverer_list.append(deliverer)
        print(f"\tSuccessfully created Deliverer: {deliverer}\n")

        address_data = {
            "deliverer": deliverer,
            "city": fake.city(),
            "district": fake.state(),
            "ward": fake.city_suffix(),
            "detail_address": fake.street_address()
        }
        address = Address.objects.create(**address_data)
        print(f"\tSuccessfully created Address: {address}")

        basic_info_data = {
            "deliverer": deliverer,
            "full_name": fake.name(),
            "given_name": fake.first_name(),
            "gender": fake.random_element(elements=('MALE', 'FEMALE', 'OTHER')),
            "date_of_birth": fake.date_of_birth(minimum_age=18, maximum_age=60),
            "hometown": fake.city(),
            "city": fake.city(),
            "district": fake.state(),
            "ward": fake.city_suffix(),
            "address": fake.street_address(),
            "citizen_identification": fake.ssn()
        }
        basic_info = BasicInfo.objects.create(**basic_info_data)
        print(f"\tSuccessfully created Basic Info: {basic_info}")

        driver_license_data = {
            "deliverer": deliverer,
            "license_front": fake.image_url(),
            "license_back": fake.image_url(),
            "vehicle_type": fake.word(),
            "license_plate": fake.license_plate(),
            "registration_certificate": fake.image_url()
        }
        driver_license = DriverLicense.objects.create(**driver_license_data)
        print(f"\tSuccessfully created Driver License: {driver_license}")

        emergency_contact_data = {
            "deliverer": deliverer,
            "name": fake.name(),
            "relationship": fake.random_element(elements=['Father', 'Mother', 'Sibling', 'Friend']),
            "phone_number": generate_phone_number()
        }
        emergency_contact = EmergencyContact.objects.create(**emergency_contact_data)
        print(f"\tSuccessfully created Emergency Contact: {emergency_contact}")

        operation_info_data = {
            "deliverer": deliverer,
            "city": fake.city(),
            "operation_type": fake.random_element(elements=['HUB', 'PART_TIME']),
            "operational_area": fake.street_address(),
            "operational_time": "9:00-18:00"
        }
        operation_info = OperationInfo.objects.create(**operation_info_data)
        print(f"\tSuccessfully created Operation Info: {operation_info}")

        other_info_data = {
            "deliverer": deliverer,
            "occupation": fake.job(),
            "details": fake.text(max_nb_chars=200),
            "judicial_record": fake.image_url()
        }
        other_info = OtherInfo.objects.create(**other_info_data)
        print(f"\tSuccessfully created Other Info: {other_info}")

        residency_info_data = {
            "deliverer": deliverer,
            "is_same_as_ci": fake.boolean(),
            "city": fake.city() if not basic_info_data['city'] else "",
            "district": fake.state() if not basic_info_data['district'] else "",
            "ward": fake.city_suffix() if not basic_info_data['ward'] else "",
            "address": fake.street_address() if not basic_info_data['address'] else "",
            "tax_code": fake.ssn(),
            "email": fake.email()
        }
        residency_info = ResidencyInfo.objects.create(**residency_info_data)
        print(f"\tSuccessfully created Residency Info: {residency_info}")
    
    return deliverer_list


def run():
    load_deliverer()