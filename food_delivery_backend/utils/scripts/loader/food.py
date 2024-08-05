import random, os
from faker import Faker

from django.conf import settings
from django.contrib.auth.hashers import make_password

from account.models import User
from food.models import (
    Dish, DishLike, 
    DishCategory, DishAdditionalOption, DishSizeOption
)
from restaurant.models import Restaurant
from review.models import DishReview, DishReviewLike

from utils.function import load_intermediate_model
from utils.scripts.data import dish_categories

fake = Faker()

def load_food(
    max_categories=0, 
    max_dishes=0,
    max_dish_likes=0,
    max_dish_reviews=25,
    max_dish_reviews_like=25,
    ):
    model_list = [
        Dish, DishLike, 
        DishCategory, DishAdditionalOption, DishSizeOption,
        # DishReview, DishReviewLike
    ]
    
    for model in model_list:
        model.objects.all().delete()

    user_list = User.objects.all()
    restaurant_list = Restaurant.objects.all()

    print("________________________________________________________________")
    print("DISH CATEGORIES:")
    category_list = []
    for x in dish_categories:
        category_data = {
            "name": x.get('name'),
            "description": x.get('description', fake.text(max_nb_chars=200)),
            "image": x.get('image'),
        }
        category, _ = DishCategory.objects.get_or_create(**category_data)
        category_list.append(category)
        print(f"\tSuccessfully created Dish Category: {category}")

    print("________________________________________________________________")
    print("DISHES:")
    dish_list = []
    for category in category_list:
        category_name = category.name.lower().replace(' ', '_')
        category_folder_path = os.path.join(settings.MEDIA_ROOT, f"food/{category_name}")
        if not os.path.exists(category_folder_path):
            print(f"Category folder not found: {category_folder_path}")
            continue
        else:
            tmp = os.listdir(category_folder_path).copy()
            for i, image_file in enumerate(os.listdir(category_folder_path)):
                if i >= max_dishes: break
                dish_data = {
                    "name": category.name + ' ' + fake.word() + ' ' + fake.word(),
                    "description": fake.text(max_nb_chars=200),
                    "original_price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=10, max_value=100),
                    "discount_price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
                    "rating": random.uniform(1, 5),
                    "number_of_reviews": fake.random_int(min=0, max=1000),
                    "category": category,
                    "image": f"{category_name}/{tmp.pop(random.randint(0, len(tmp) - 1))}",
                    # "image": f"{category_name}/{image_file}",
                }
                
                dish, _ = Dish.objects.get_or_create(**dish_data)
                dish_list.append(dish)
                print(f"\tSuccessfully created Dish: {dish}, {dish.image}\n")
                
                for _ in range(random.randint(1, 5)):
                    option_data = {
                        "dish": dish,
                        "name": fake.word(),
                        "price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=1, max_value=20)
                    }
                    option = DishAdditionalOption.objects.create(**option_data)
                    print(f"\tSuccessfully created Dish Additional Option: {option}")
                print()
                
                size_options = ["Small", "Medium", "Large", "XL Large with Sauces"]
                for size in size_options:
                    size_data = {
                        "dish": dish,
                        "size": size,
                        "price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=1, max_value=50)
                    }
                    size_option = DishSizeOption.objects.create(**size_data)
                    print(f"\tSuccessfully created Dish Size Option: {size_option}")
                print()
         
    print("________________________________________________________________")
    print("DISH LIKES:")
    load_intermediate_model(
        model_class=DishLike,
        primary_field='dish',
        related_field='user',
        primary_objects=dish_list,
        related_objects=user_list,
        max_items=max_dish_likes,
    )

    review_attributes = {
        'rating': lambda: fake.random_int(min=1, max=5),
        'title': lambda: fake.sentence(nb_words=6),
        'content': lambda: fake.text(max_nb_chars=200)
    }

    print("________________________________________________________________")
    print("DISH REVIEWS:")
    review_list = load_intermediate_model(
        model_class=DishReview,
        primary_field='dish',
        related_field='user',
        primary_objects=dish_list,
        related_objects=user_list,
        max_items=max_dish_reviews,
        attributes=review_attributes
    )

    print("________________________________________________________________")
    print("DISH REVIEW LIKES:")
    load_intermediate_model(
        model_class=DishReviewLike,
        primary_field='review',
        related_field='user',
        primary_objects=review_list,
        related_objects=user_list,
        max_items=max_dish_reviews_like,
    )

    return dish_list
