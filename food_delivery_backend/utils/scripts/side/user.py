import random
from faker import Faker
from datetime import datetime, timedelta

from django.utils import timezone
from django.db import transaction
from django.contrib.auth.hashers import make_password

from account.models import (
    User, OTP,
    Profile, UserLocation, 
    Setting, SecuritySetting 
)

from food.models import DishCategory
from restaurant.models import *
from utils.objects import Point, Distance
from order.models import Order, Delivery, DeliveryRequest
from deliverer.models import Deliverer

def run(mode=None, *args):
    # print("________________________________________________________________")
    # print(type(args))
    # from django.apps import apps

    # # Get all models
    # all_models = apps.get_models()

    # # Print model names
    # for model in all_models:
    #     print(model.__name__, len(model.objects.all()))

    def _find_nearest_deliverer(restaurant, deliverers):
        restaurant_point = Point(restaurant.basic_info.latitude, restaurant.basic_info.longitude)
        nearest_deliverer = None
        min_distance = float('inf')

        for deliverer in deliverers:
            deliverer_point = Point(deliverer.current_latitude, deliverer.current_longitude)
            distance = Distance.haversine(restaurant_point, deliverer_point)
            if distance < min_distance:
                min_distance = distance
                nearest_deliverer = deliverer

        return nearest_deliverer
    
    restaurant = Restaurant.objects.filter(basic_info__name="Hill, Thompson and Rivera").first()
    available_deliverers = Deliverer.objects.filter(is_active=True, is_occupied=False)
    print(restaurant)
    
    # result = _find_nearest_deliverer(restaurant, available_deliverers)
    # if result:
    #     print(f"Deliverer ID: {result.id}")
    #     print(f"User: {result.user.id} - {result.user.phone_number} - {result.user.profile.name}")

    result = DeliveryRequest.objects.all().order_by('-created_at').first()
    if result:
        latest_order = result.delivery.order
        print('Total price', result.delivery.order.total_price, pretty=True)
        result = result.deliverer
        print(f"Deliverer ID: {result.id}")
        print(f"User: {result.user.id} - {result.user.phone_number} - {result.user.profile.name}")

        latest_request_from_deliverer = result.requests.all()[0]
        _order = latest_request_from_deliverer.delivery.order
        print(_order, latest_order, pretty=True, sep="\n")

    x = (1, 2)
    a, b = x
    print(a, b, pretty=True)

    # print([1][0:])
    # users = Profile.objects.all()
    # for user in users:
    #     user.avatar = None
    #     user.save(update_fields=['avatar'])

    # deliverers = Deliverer.objects.all()
    # for deliverer in deliverers:
    #     deliverer.avatar = None
    #     deliverer.save(update_fields=['avatar']) 
    # print(User.objects.all()[0].profile.avatar == '')