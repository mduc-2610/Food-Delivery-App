import random
from faker import Faker
from django.db import transaction

from account.models import User
from deliverer.models import (
    Address, BasicInfo, DriverLicense, EmergencyContact, 
    OperationInfo, OtherInfo, ResidencyInfo, Deliverer
)
from utils.decorators import script_runner
from utils.function import (
    load_one_to_many_model, 
    load_normal_model,
    generate_phone_number, 
    update_attr
)

fake = Faker()

MODEL_MAP = {
    'address': Address,
    'basic_info': BasicInfo,
    'driver_license': DriverLicense,
    'emergency_contact': EmergencyContact,
    'operation_info': OperationInfo,
    'other_info': OtherInfo,
    'residency_info': ResidencyInfo,
    'deliverer': Deliverer
}

@script_runner(MODEL_MAP)
@transaction.atomic
def load_deliverer(
    max_deliverers=40,
    models_to_update=None,
    map_queryset=None,
    action=None,
):
    if Deliverer in models_to_update:
        print("________________________________________________________________")
        print("DELIVERERS:")
        user_list = list(map_queryset.get(User))
        deliverer_list = load_normal_model(
            model_class=Deliverer,
            max_items=max_deliverers,
            attributes={"user": lambda: user_list.pop(random.randint(0, len(user_list) - 1))},
            action=action
        )

    if Address in models_to_update:
        print("________________________________________________________________")
        print("ADDRESSES:")
        for deliverer in map_queryset.get(Deliverer):
            address_data = {
                "deliverer": deliverer,
                "city": fake.city(),
                "district": fake.state(),
                "ward": fake.city_suffix(),
                "detail_address": fake.street_address()
            }
            address = None
            if action == "delete":
                address = Address.objects.create(**address_data)
            else:
                address = Address.objects.get(deliverer__id=deliverer.id)
                address = update_attr(address, **address_data)
            print(f"\tSuccessfully created Address: {address}")

    if BasicInfo in models_to_update:
        print("________________________________________________________________")
        print("BASIC INFO:")
        for deliverer in map_queryset.get(Deliverer):
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
            basic_info = None
            if action == "delete":
                basic_info = BasicInfo.objects.create(**basic_info_data)
            else:
                basic_info = BasicInfo.objects.get(deliverer__id=deliverer.id)
                basic_info = update_attr(basic_info, **basic_info_data)
            print(f"\tSuccessfully created Basic Info: {basic_info}")

    if DriverLicense in models_to_update:
        print("________________________________________________________________")
        print("DRIVER LICENSES:")
        for deliverer in map_queryset.get(Deliverer):
            driver_license_data = {
                "deliverer": deliverer,
                "license_front": fake.image_url(),
                "license_back": fake.image_url(),
                "vehicle_type": fake.word(),
                "license_plate": fake.license_plate(),
                "registration_certificate": fake.image_url()
            }
            driver_license = None
            if action == "delete":
                driver_license = DriverLicense.objects.create(**driver_license_data)
            else:
                driver_license = DriverLicense.objects.get(deliverer__id=deliverer.id)
                driver_license = update_attr(driver_license, **driver_license_data)
            print(f"\tSuccessfully created Driver License: {driver_license}")

    if EmergencyContact in models_to_update:
        print("________________________________________________________________")
        print("EMERGENCY CONTACTS:")
        for deliverer in map_queryset.get(Deliverer):
            emergency_contact_data = {
                "deliverer": deliverer,
                "name": fake.name(),
                "relationship": fake.random_element(elements=['Father', 'Mother', 'Sibling', 'Friend']),
                "phone_number": generate_phone_number()
            }
            emergency_contact = None
            if action == "delete":
                emergency_contact = EmergencyContact.objects.create(**emergency_contact_data)
            else:
                emergency_contact = EmergencyContact.objects.get(deliverer__id=deliverer.id)
                emergency_contact = update_attr(emergency_contact, **emergency_contact_data)
            print(f"\tSuccessfully created Emergency Contact: {emergency_contact}")

    if OperationInfo in models_to_update:
        print("________________________________________________________________")
        print("OPERATION INFO:")
        for deliverer in map_queryset.get(Deliverer):
            operation_info_data = {
                "deliverer": deliverer,
                "city": fake.city(),
                "operation_type": fake.random_element(elements=['HUB', 'PART_TIME']),
                "operational_area": fake.street_address(),
                "operational_time": "9:00-18:00"
            }
            operation_info = None
            if action == "delete":
                operation_info = OperationInfo.objects.create(**operation_info_data)
            else:
                operation_info = OperationInfo.objects.get(deliverer__id=deliverer.id)
                operation_info = update_attr(operation_info, **operation_info_data)
            print(f"\tSuccessfully created Operation Info: {operation_info}")

    if OtherInfo in models_to_update:
        print("________________________________________________________________")
        print("OTHER INFO:")
        for deliverer in map_queryset.get(Deliverer):
            other_info_data = {
                "deliverer": deliverer,
                "occupation": fake.job(),
                "details": fake.text(max_nb_chars=200),
                "judicial_record": fake.image_url()
            }
            other_info = None
            if action == "delete":
                other_info = OtherInfo.objects.create(**other_info_data)
            else:
                other_info = OtherInfo.objects.get(deliverer__id=deliverer.id)
                other_info = update_attr(other_info, **other_info_data)
            print(f"\tSuccessfully created Other Info: {other_info}")

    if ResidencyInfo in models_to_update:
        print("________________________________________________________________")
        print("RESIDENCY INFO:")
        for deliverer in map_queryset.get(Deliverer):
            residency_info_data = {
                "deliverer": deliverer,
                "is_same_as_ci": fake.boolean(),
                "city": fake.city(),
                "district": fake.state(),
                "ward": fake.city_suffix(),
                "address": fake.street_address(),
                "tax_code": fake.ssn(),
                "email": fake.email()
            }
            residency_info = None
            if action == "delete":
                residency_info = ResidencyInfo.objects.create(**residency_info_data)
            else:
                residency_info = ResidencyInfo.objects.get(deliverer__id=deliverer.id)
                residency_info = update_attr(residency_info, **residency_info_data)
            print(f"\tSuccessfully created Residency Info: {residency_info}")

    return [deliverer for deliverer in map_queryset.get(Deliverer)]

def run(*args):
    if len(args) > 0:
        action = args[0]
        models = args[1:] if len(args) > 1 else []
        load_deliverer(action, *models)
    else:
        load_deliverer()
