import random
from faker import Faker

from django.contrib.auth.hashers import make_password

from account.models import User
from food.models import (
    Dish, DishLike, 
    DishCategory, DishAdditionalOption, DishSizeOption
)

from utils.function import load_intermediate_model

fake = Faker()

def load_food(
    max_categories=0, 
    max_dishes=0,
    max_dish_likes=0,
    ):
    model_list = [
        Dish, DishLike, 
        DishCategory, DishAdditionalOption, DishSizeOption
    ]
    
    for model in model_list:
        model.objects.all().delete()

    user_list = User.objects.all()
    
    print("________________________________________________________________")
    print("DISH CATEGORIES:")
    category_list = []
    for _ in range(max_categories):
        category_data = {
            "name": fake.word() + " " + fake.word(),
            "description": fake.text(max_nb_chars=200)
        }
        category, _ = DishCategory.objects.get_or_create(**category_data)
        category_list.append(category)
        print(f"\tSuccessfully created Dish Category: {category}")

    print("________________________________________________________________")
    print("DISHES:")
    dish_list = []
    for _ in range(max_dishes):
        dish_data = {
            "name": fake.word(),
            "description": fake.text(max_nb_chars=200),
            "original_price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=10, max_value=100),
            "discount_price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
            "rating": random.randint(1, 5),
            "number_of_reviews": fake.random_int(min=0, max=1000),
            "category": random.choice(category_list)
        }
        dish, _ = Dish.objects.get_or_create(**dish_data)
        dish_list.append(dish)
        print(f"\tSuccessfully created Dish: {dish}")

        for _ in range(random.randint(1, 5)):
            option_data = {
                "dish": dish,
                "name": fake.word(),
                "price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=1, max_value=20)
            }
            option = DishAdditionalOption.objects.create(**option_data)
            print(f"\tSuccessfully created Dish Additional Option: {option}")

        size_options = ["Small", "Medium", "Large", "XL Large with Sauces"]
        for size in size_options:
            size_data = {
                "dish": dish,
                "size": size,
                "price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=1, max_value=50)
            }
            size_option = DishSizeOption.objects.create(**size_data)
            print(f"\tSuccessfully created Dish Size Option: {size_option}\n")

         
    print("________________________________________________________________")
    print("DISH LIKES:")
    load_intermediate_model(
        model_class=DishLike,
        primary_field='dish',
        related_field='user',
        primary_objects=dish_list,
        related_objects=user_list,
        max_items=0
    )

    return dish_list
