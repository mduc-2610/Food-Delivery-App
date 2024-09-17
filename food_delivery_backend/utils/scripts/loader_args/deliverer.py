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
    generate_latitude, 
    generate_longitude,
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
        user_list = list(map_queryset.get(User))
        deliverer_list = load_normal_model(
            model_class=Deliverer,
            max_items=max_deliverers,
            attributes={
                "current_latitude": lambda: generate_latitude(),
                "current_longitude": lambda: generate_longitude(),
                "is_active": lambda: random.choice([True] * 5 + [False] * 3)
            },
            oto_attribute={
                "user": lambda: user_list.pop(random.randint(0, len(user_list) - 1)),
            },
            action=action
        )

    if Address in models_to_update:
        deliverer_list = map_queryset.get(Deliverer)
        load_normal_model(
            model_class=Address,
            max_items=0,
            attributes={
                "city": lambda: fake.city(),
                "district": lambda: fake.state(),
                "ward": lambda: fake.city_suffix(),
                "detail_address": lambda: fake.street_address()
            },
            oto_field='deliverer',
            oto_objects=deliverer_list,
            action=action
        )

    if BasicInfo in models_to_update:
        deliverer_list = map_queryset.get(Deliverer)
        load_normal_model(
            model_class=BasicInfo,
            max_items=0,
            attributes={
                "full_name": lambda: fake.name(),
                "given_name": lambda: fake.first_name(),
                "gender": lambda: fake.random_element(elements=('MALE', 'FEMALE', 'OTHER')),
                "date_of_birth": lambda: fake.date_of_birth(minimum_age=18, maximum_age=60),
                "hometown": lambda: fake.city(),
                "city": lambda: fake.city(),
                "district": lambda: fake.state(),
                "ward": lambda: fake.city_suffix(),
                "address": lambda: fake.street_address(),
                "citizen_identification": lambda: fake.ssn()
            },
            oto_field='deliverer',
            oto_objects=deliverer_list,
            action=action
        )

    if DriverLicense in models_to_update:
        deliverer_list = map_queryset.get(Deliverer)
        load_normal_model(
            model_class=DriverLicense,
            max_items=0,
            attributes={
                "driver_license_front": lambda: fake.image_url(),
                "driver)license_back": lambda: fake.image_url(),
                "motorcycle_registration_certificate_front": lambda: fake.image_url(),
                "motorcycle_registration_certificate_back": lambda: fake.image_url(),
                "vehicle_type": lambda: fake.word(),
                "license_plate": lambda: fake.license_plate(),
            },
            oto_field='deliverer',
            oto_objects=deliverer_list,
            action=action
        )

    if EmergencyContact in models_to_update:
        deliverer_list = map_queryset.get(Deliverer)
        load_normal_model(
            model_class=EmergencyContact,
            max_items=0,
            attributes={
                "name": lambda: fake.name(),
                "relationship": lambda: fake.random_element(elements=['Father', 'Mother', 'Sibling', 'Friend']),
                "phone_number": lambda: generate_phone_number()
            },
            oto_field='deliverer',
            oto_objects=deliverer_list,
            action=action
        )

    if OperationInfo in models_to_update:
        deliverer_list = map_queryset.get(Deliverer)
        load_normal_model(
            model_class=OperationInfo,
            max_items=0,
            attributes={
                "city": lambda: fake.city(),
                "operation_type": lambda: fake.random_element(elements=['HUB', 'PART_TIME']),
                "operational_area": lambda: fake.street_address(),
                "operational_time": lambda: "9:00-18:00"
            },
            oto_field='deliverer',
            oto_objects=deliverer_list,
            action=action
        )

    if OtherInfo in models_to_update:
        deliverer_list = map_queryset.get(Deliverer)
        load_normal_model(
            model_class=OtherInfo,
            max_items=0,
            attributes={
                "occupation": lambda: fake.job(),
                "details": lambda: fake.text(max_nb_chars=200),
                "judicial_record": lambda: fake.image_url()
            },
            oto_field='deliverer',
            oto_objects=deliverer_list,
            action=action
        )

    if ResidencyInfo in models_to_update:
        deliverer_list = map_queryset.get(Deliverer)
        print("RESIDENCY INFO:")
        load_normal_model(
            model_class=ResidencyInfo,
            max_items=0,
            attributes={
                "is_same_as_ci": lambda: fake.boolean(),
                "city": lambda: fake.city(),
                "district": lambda: fake.state(),
                "ward": lambda: fake.city_suffix(),
                "address": lambda: fake.street_address(),
                "tax_code": lambda: fake.ssn(),
                "email": lambda: fake.email()
            },
            oto_field='deliverer',
            oto_objects=deliverer_list,
            action=action
        )

    return [deliverer for deliverer in map_queryset.get(Deliverer)]

def run(*args):
    load_deliverer(*args)
