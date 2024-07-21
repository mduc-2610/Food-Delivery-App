from django.utils import timezone
from django.contrib.auth.hashers import make_password

from account.models import User
from deliverer.models import Deliverer
from restaurant.models import Restaurant
from food.models import Dish

from utils.scripts.loader import (
    load_deliverer,
    load_food,
    load_notification,
    load_order,
    load_restaurant,
    load_review,
    load_social,
    load_user,
)


def run():
    MAX_USERS = 100
    
    MAX_RESTAURANTS = 50
    
    MAX_DELIVERERS = 30

    MAX_MESSAGES = 100
    MAX_NOTIFICATIONS = 150
    MAX_USER_NOTIFICATIONS = 30

    MAX_CATEGORIES = 30
    MAX_DISHES = 100
    MAX_DISH_LIKES = 50
    
    MAX_PROMOTIONS = 200
    MAX_ORDER_PROMOTIONS = 30
    MAX_RESTAURANT_PROMOTIONS = 50
    MAX_USER_PROMOTIONS = 40
    MAX_ORDERS = 80
    MAX_DELIVERIES = 100
    MAX_CARTS = 100

    MAX_REVIEWS = 100
    MAX_REVIEW_LIKES = 100

    MAX_POSTS = 100
    MAX_COMMENTS = 100
    MAX_POST_LIKES = 50
    MAX_COMMENT_LIKES = 50
    MAX_IMAGES = 100
    
    load_user(max_users=MAX_USERS)

    load_deliverer(max_deliverers=MAX_DELIVERERS)    
    
    load_restaurant(max_restaurants=MAX_RESTAURANTS)

    load_notification(
        max_notifications=MAX_NOTIFICATIONS, 
        max_messages=MAX_MESSAGES,
        max_user_notifications=MAX_USER_NOTIFICATIONS
    )
    
    load_food(
        max_categories=MAX_CATEGORIES, 
        max_dishes=MAX_DISHES,
        max_dish_likes=MAX_DISH_LIKES,
    )

    load_order(
        max_promotions=MAX_PROMOTIONS,
        max_order_promotions=MAX_ORDER_PROMOTIONS,
        max_restaurant_promotions=MAX_RESTAURANT_PROMOTIONS,
        max_user_promotions=MAX_USER_PROMOTIONS,
        max_orders=MAX_ORDERS,
        max_deliverers=MAX_DELIVERIES,
        max_carts=MAX_CARTS,
        max_dishes=MAX_DISHES
    )

    load_review(
        max_reviews=MAX_REVIEWS,
        max_review_likes=MAX_REVIEW_LIKES,
    )

    load_social(
        max_posts=MAX_POSTS,
        max_comments=MAX_COMMENTS,
        max_comment_likes=MAX_COMMENT_LIKES,
        max_post_likes=MAX_POST_LIKES,
        max_images=MAX_IMAGES,
    )