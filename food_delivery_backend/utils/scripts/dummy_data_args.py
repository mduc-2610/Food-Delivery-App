from django.utils import timezone
from django.contrib.auth.hashers import make_password

from account.models import User
from deliverer.models import Deliverer
from restaurant.models import Restaurant
from food.models import Dish

from utils.scripts.loader_args import (
    load_deliverer,
    load_food,
    load_notification,
    load_order,
    load_restaurant,
    load_review,
    load_social,
    load_user,
)

def run(*args):
    
    MAX_USERS = 100
    
    MAX_RESTAURANTS = 50
    
    MAX_DELIVERERS = 30

    MAX_MESSAGES = 100
    MAX_NOTIFICATIONS = 150
    MAX_USER_NOTIFICATIONS = 30

    MAX_CATEGORIES = 30
    MAX_DISHES = 150
    MAX_DISH_LIKES = 50
    
    MAX_PROMOTIONS = 200
    MAX_ORDER_PROMOTIONS = 30
    MAX_RESTAURANT_PROMOTIONS = 50
    MAX_USER_PROMOTIONS = 40
    MAX_ORDERS = 80
    MAX_DELIVERIES = 100
    MAX_CARTS = 100
    MAX_RESTAURANT_CATEGORIES=3
    MAX_RESTAURANT_CATEGORY_DISHES=8

    MAX_REVIEWS = 100
    MAX_REVIEW_LIKES = 100

    MAX_POSTS = 6
    MAX_COMMENTS = 20
    MAX_POST_LIKES = 30
    MAX_COMMENT_LIKES = 30
    MAX_POST_IMAGES=15
    MAX_COMMENT_IMAGES=5

    loaders = [
        load_user, # 0
        load_deliverer, # 1
        load_food, # 2
        load_restaurant, # 3
        load_notification, # 4
        load_order, # 5
        load_review, # 6
        load_social, # 7
    ]
    start_index = 0
    end_index = len(loaders)
    try:
        start_index = int(args[0])
        end_index = int(args[1])
    except:
        print('Invalid start_index or end_index type.')

    if start_index < 0 or end_index > len(loaders) or start_index > end_index:
        print("Invalid start_index or end_index values.")
        return

    for index in range(start_index, end_index):
        print(f"Running loader {index + 1}/{len(loaders)}: {loaders[index].__name__}")
        loaders[index]()

