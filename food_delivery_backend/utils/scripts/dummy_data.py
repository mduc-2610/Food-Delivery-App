import random
from faker import Faker

from django.utils import timezone
from django.contrib.auth.hashers import make_password

from account.models import User
from deliverer.models import Deliverer
from restaurant.models import Restaurant

from utils.scripts.loader import (
    load_user, load_deliverer, load_restaurant
)

fake = Faker()

def generate_phone_number():
    return f"+84{random.randint(100000000, 99999999999)}"

def run():
    MAX_NUMBER_USERS = 100
    MAX_NUMBER_RESTAURANTS = 50
    MAX_NUMBER_DELIVERERS = 30

    load_user(MAX_NUMBER_USERS)
    user_list = User.objects.all()

    load_deliverer(MAX_NUMBER_DELIVERERS, user_list)    
    deliverer_list = Deliverer.objects.all()
    
    load_restaurant(MAX_NUMBER_RESTAURANTS, user_list)
    restaurant_list = Restaurant.objects.all()