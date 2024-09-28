import random
import re
import builtins
import inspect
import math
import sys
import random
from datetime import datetime, timedelta


from django.apps import apps

def update_attr(instance, **kwargs):
    save = kwargs.pop('save', True)
    for k, v in kwargs.items():
        setattr(instance, k, v() if callable(v) else v )
    if save:
        instance.save()
    return instance

def transform_value(value):
    return value() if callable(value) else value

def camel_to_full_upper(name, sep=' '):
    return re.sub('([a-z0-9])([A-Z])', fr'\1{sep}\2', name).upper()

def load_one_to_many_model(
        model_class,
        primary_field,
        primary_objects,
        max_related_count,
        oto_field=None,
        oto_field_objects=[],
        attributes={}, 
        action="delete"
    ):
    created_objects = []
    if model_class: 
        print("________________________________________________________________")
        print(f"{camel_to_full_upper(model_class.__name__)}:")

    if action == "delete":    
        if type(primary_objects) is not list:
            primary_objects = list(primary_objects)
        if oto_field and oto_field_objects:
            for oto_obj in oto_field_objects:
                    """
                    Ex: Order, Delivery and Deliverer
                    """
                    data = {
                        primary_field: random.choice(primary_objects),
                        oto_field: oto_obj,
                        **{attr: transform_value(value) for attr, value in attributes.items()}
                    }
                    created_object, _ = model_class.objects.get_or_create(**data)
                    created_objects.append(created_object)
                    print(f"\tSuccessfully created {model_class.__name__}: {created_object}")
        else:
            for primary_obj in primary_objects:
                for _ in range(random.randint(0, max(max_related_count, 1))):
                    data = {
                        primary_field: primary_obj,
                        **{attr: transform_value(value) for attr, value in attributes.items()}
                    }
                    created_object, _ = model_class.objects.get_or_create(**data)
                    created_objects.append(created_object)
                    print(f"\tSuccessfully created {model_class.__name__}: {created_object}")
    else:
        if attributes:
            for instance in model_class.objects.all():
                update_attr(instance, **attributes)
                print(f"\tSuccessfully update{instance}")
    return created_objects

def load_normal_model(
    model_class,
    max_items,
    oto_attribute={},
    oto_field=None,
    oto_objects=[],
    attributes={}, 
    action="delete"
):
    created_objects = []
    if model_class: 
        print("________________________________________________________________")
        print(f"{camel_to_full_upper(model_class.__name__)}:")
        
    if action == "delete":    
        if oto_field and oto_objects:
            for oto_obj in oto_objects:
                data = {
                    oto_field: oto_obj,
                    **{attr: transform_value(value) for attr, value in attributes.items()},
                }
                created_object, _ = model_class.objects.get_or_create(**data)
                created_objects.append(created_object)
                print(f"\tSuccessfully created {model_class.__name__}: {created_object}")
        else:  
            for _ in range(max_items):
                data = {
                    **{attr: transform_value(value) for attr, value in attributes.items()}
                }
                if oto_attribute:
                    data.update(**{attr: transform_value(value) for attr, value in oto_attribute.items()})
                created_object, _ = model_class.objects.get_or_create(**data)
                created_objects.append(created_object)
                print(f"\tSuccessfully created {model_class.__name__}: {created_object}")
    else:
        if attributes:
            for instance in model_class.objects.all():
                update_attr(instance, **attributes)
                print(f"\tSuccessfully update{instance}")
    return created_objects

def load_intermediate_model(
    model_class,
    primary_field,
    related_field,
    primary_objects,
    max_items,
    related_objects=[],
    min_items=0,
    attributes={},
    query_attributes=[],
    action=None
):
    if model_class: 
        print("________________________________________________________________")
        print(f"{camel_to_full_upper(model_class.__name__)}:")
        
    if not action: action = "delete"
    created_objects = []
    if action == "delete":
        if not isinstance(primary_objects, list):
            primary_objects = list(primary_objects)
        if not isinstance(related_objects, list):
            related_objects = list(related_objects)

        for primary_obj in primary_objects:
            if query_attributes:
                """
                Ex: RestaurantCartDish
                The cart (Restaurant Cart) will contain many dishes
                Restaurant Cart will have restaurant, from restaurant will get many dishes
                """
                tmp_related_objects = list(getattr(getattr(primary_obj, query_attributes[0]), query_attributes[1]).all()).copy()
                print(f"Number of related objects: {len(tmp_related_objects)}")
            else:
                tmp_related_objects = related_objects.copy()

            for _ in range(random.randint(min_items, min(len(tmp_related_objects), max_items))):
                if not tmp_related_objects:
                    break
                related_obj = tmp_related_objects.pop(random.randint(0, len(tmp_related_objects) - 1))
                if primary_obj == related_obj:
                    continue
                
                data = {
                    primary_field: primary_obj,
                    related_field: related_obj,
                    **{attr: transform_value(value) for attr, value in attributes.items()}
                }
                created_object = model_class.objects.create(**data)
                created_objects.append(created_object)
                print(f"\tSuccessfully created {model_class.__name__}: {created_object}")
    else:
        if attributes:
            for instance in model_class.objects.all():
                update_attr(instance, **attributes)
                print(f"\tSuccessfully update {instance}")
            
    return created_objects

def load_oto_with_more_than_two_fk(
    model_class,
    oto_field,
    related_field_1,
    related_field_2,
    max_items,
    min_items=0,
    oto_objects=[],
    related_objects_1=[],
    related_objects_2=[],
    attributes={},
    query_attributes=[],
    action=None
):
    if model_class: 
        print("________________________________________________________________")
        print(f"{camel_to_full_upper(model_class.__name__)}:")
        
    if not action: action = "delete"
    created_objects = []
    if action == "delete":
        if not isinstance(oto_objects, list):
            oto_objects = list(oto_objects)
        if not isinstance(related_objects_1, list):
            related_objects_1 = list(related_objects_1)
        if not isinstance(related_objects_2, list):
            related_objects_2 = list(related_objects_2)

        for _oto_obj in oto_objects:
            for _ in range(random.randint(min_items, max_items)):
                data = {
                    related_field_1: random.choice(related_objects_1),
                    related_field_2: random.choice(related_objects_2),
                    **{attr: transform_value(value) for attr, value in attributes.items()}
                }
                filter = {
                    f"{oto_field}": _oto_obj,
                }
                created_object, created = model_class.objects.get_or_create(
                    **filter,
                    defaults=data
                )
                created_objects.append(created_object)
                print(f"\tSuccessfully created {model_class.__name__}: {created_object}")
    else:
        if attributes:
            for instance in model_class.objects.all():
                update_attr(instance, **attributes)
                print(f"\tSuccessfully update {instance}")
            
    return created_objects


from datetime import timedelta
from django.utils import timezone
import calendar

def calculate_expired_at(delayed):
    unit = delayed[-1]  
    value = int(delayed[:-1])  

    if unit == 's':
        expired_at = timezone.now() + timedelta(seconds=value)
    elif unit == 'm':  
        expired_at = timezone.now() + timedelta(minutes=value)
    elif unit == 'h':
        expired_at = timezone.now() + timedelta(hours=value)
    elif unit == 'd':
        expired_at = timezone.now() + timedelta(days=value)
    elif unit == 'M':  
        now = timezone.now()
        month = now.month - 1 + value
        year = now.year + month // 12
        month = month % 12 + 1
        day = min(now.day, calendar.monthrange(year, month)[1])
        expired_at = now.replace(year=year, month=month, day=day)
    elif unit == 'y':
        now = timezone.now()
        try:
            expired_at = now.replace(year=now.year + value)
        except ValueError:
            expired_at = now.replace(year=now.year + value, month=2, day=28)
    else:
        raise ValueError("Invalid time unit in delayed value.")

    return expired_at


from faker import Faker

fake = Faker()
city_coordinates = {
    "Hanoi": {"lat": (20.8, 21.1), "lng": (105.7, 106.0)},
    "Ho Chi Minh City": {"lat": (10.7, 10.9), "lng": (106.6, 106.8)},
    "Da Nang": {"lat": (15.9, 16.2), "lng": (107.9, 108.3)},
}

def generate_latitude(country='Vietnam', city="Hanoi"):
    if country == 'Vietnam':
        if city in city_coordinates:
            lat_range = city_coordinates[city]['lat']
            return random.uniform(lat_range[0], lat_range[1])
        else:
            return random.uniform(8.0, 23.0)
    return fake.latitude()

def generate_longitude(country='Vietnam', city="Hanoi"):
    if country == 'Vietnam':
        if city in city_coordinates:
            lng_range = city_coordinates[city]['lng']
            return random.uniform(lng_range[0], lng_range[1])
        else:
            return random.uniform(102.0, 110.0)
    return fake.longitude()

def generate_phone_number():
    return f"+84{random.randint(100000000, 999999999)}"

def calculate_distance(lat1, lon1, lat2, lon2):
    lat1 = math.radians(lat1)
    lon1 = math.radians(lon1)
    lat2 = math.radians(lat2)
    lon2 = math.radians(lon2)

    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = math.sin(dlat / 2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2)**2
    c = 2 * math.asin(math.sqrt(a))

    r = 6371

    distance = r * c
    return distance

def camel_to_snake(name, sep='-'):
    return re.sub('([a-z0-9])([A-Z])', fr'\1{sep}\2', name).lower()

def mapping_endpoint(model, type):
    return f'/api/{model._meta.app_label}' + (f'/{camel_to_snake(model.__name__)}' if type == "many" else '')

def get_base_ip(request):
    try:
        return f"{'/'.join(request.build_absolute_uri().split('/')[0: 3])}"
    except:
        raise ValueError

def get_related_url(request, model, obj, field, type):
    if isinstance(field, str):
        field = model._meta.get_field(field)
    field = field.name.replace('_', '-')

    if request:
        base_uri = f"{get_base_ip(request)}" + mapping_endpoint(model, type)
        
        if type == "many":
            uri = f"{base_uri}/{obj.pk}/{field}"
        elif type == "one":
            uri = f"{base_uri}/{field}/{obj.pk}"
        else:
            raise ValueError("Invalid relationship_type. Use 'many' or 'one'.")
        return uri
    return None


def get_related_url_2(request, model, obj, field, type='one'):
    if isinstance(field, str):
        field = model._meta.get_field(field)
    
    if field:
        view_name = field.name.replace('_', '-')
        related_model = field.model
        related_model_app_label = related_model._meta.app_label
        
        base_uri = f"{get_base_ip(request)}/api/{related_model_app_label}/{camel_to_snake(related_model.__name__, sep='_')}"
        uri = ""
        if type == "many":
            uri = f"{base_uri}/{obj.pk}/{view_name}"
        elif type == "one":
            uri = f"{base_uri}/{view_name}/{obj.pk}"
        else:
            raise ValueError("Invalid relationship_type. Use 'many' or 'one'.")
        # print(uri, pretty=True)
        return uri
    return None

def get_related_url_3(request, obj, action, detail=False):
    if request:
        return request.build_absolute_uri(
            f"/api/{obj._meta.app_label}/{camel_to_snake(obj._meta.model.__name__)}/" + f"{obj.id}/{action}" if detail else f"{action}/{obj.id}"
        )
    return None

def generate_random_time_in_year(year=None):
    if year is None:
        year = datetime.now().year  

    start_date = datetime(year, 1, 1)
    end_date = datetime(year + 1, 1, 1)  
    random_timestamp = start_date + (end_date - start_date) * random.random()
    
    return random_timestamp

def custom_print(*messages, **options):
    current_frame = inspect.currentframe()
    caller_frame = current_frame.f_back
    source_file = caller_frame.f_globals['__file__']
    line_num = caller_frame.f_lineno
    
    pretty = options.pop('pretty', False)
    separator = "__________________________________________________________"

    prefix = f"\n{separator}\n\n" if pretty else ""
    suffix = f"{separator}\n" if pretty else ""
    formatted_message = f"[{source_file}:{line_num}] {prefix}" + " ".join(map(str, messages)) + f"\n{suffix}"
    
    sys.stdout.write(formatted_message)
    sys.stdout.flush()

builtins.print = custom_print