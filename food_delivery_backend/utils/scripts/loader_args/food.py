import random
import os
from faker import Faker
from django.conf import settings
from django.db import transaction

from account.models import User
from food.models import (
    Dish, DishLike, 
    DishCategory, DishOption, DishOptionItem
)
from review.models import DishReview, DishReviewLike
from utils.function import load_intermediate_model, load_one_to_many_model
from utils.scripts.data import dish_categories, category_options
from utils.decorators import script_runner

fake = Faker()

MODEL_MAP = {
    'dish': Dish,
    'dish_like': DishLike,
    'dish_category': DishCategory,
    'dish_option': DishOption,
    'dish_option_item': DishOptionItem,
    'dish_review': DishReview,
    'dish_review_like': DishReviewLike,
}

@script_runner(MODEL_MAP)
@transaction.atomic
def load_food(
    max_categories=30, 
    max_dishes_per_category=150,
    max_likes_per_dish=50,
    max_reviews_per_dish=25,
    max_review_likes_per_dish=25,
    models_to_update=None,
    map_queryset=None,
    action=None,
):
    if DishCategory in models_to_update:
        print("________________________________________________________________")
        print("DISH CATEGORIES:")
        category_list = []
        for _x in dish_categories:
            category_data = {
                "name": _x.get('name'),
                "description": fake.word() + fake.text(max_nb_chars=200),
                "image": _x.get('image'),
            }
            category, created = DishCategory.objects.update_or_create(
                name=_x.get('name'),
                defaults=category_data
            )
            category_list.append(category)
            print(f"\tSuccessfully {'created' if created else 'updated'} Dish Category: {category}")
    
    if Dish in models_to_update:
        print("________________________________________________________________")
        print("DISHES:")
        dish_list = []
        for category in category_list:
            category_name = category.name.lower().replace(' ', '_')
            category_folder_path = os.path.join(settings.MEDIA_ROOT, f"food/{category_name}")
            
            if not os.path.exists(category_folder_path):
                print(f"Category folder not found: {category_folder_path}")
                continue
            
            image_files = os.listdir(category_folder_path)
            if not image_files: continue
            dish_list += load_one_to_many_model(
                model_class=Dish,
                primary_field='category',
                primary_objects=[category],
                max_related_objects=min(max_dishes_per_category, len(image_files)),
                attributes={
                    "name": lambda: f"{category.name} {fake.word()} {fake.word()}",
                    "description": lambda: fake.text(max_nb_chars=200),
                    "original_price": lambda: fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=10, max_value=100),
                    "discount_price": lambda: fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
                    "image": lambda image_files=image_files: f"food/{category_name}/{image_files.pop(random.randint(0, len(image_files) - 1))}",
                },
                action=action
            )
            
            for dish in dish_list:
                if category.name in category_options:
                    options = category_options[category.name]
                    for option_type, option_list in options.items():
                        dish_option, _ = DishOption.objects.update_or_create(dish=dish, name=option_type)
                        
                        for option_name in option_list:
                            DishOptionItem.objects.update_or_create(
                                option=dish_option,
                                name=option_name,
                                price=float(fake.pydecimal(left_digits=1, right_digits=2, positive=True, min_value=0.5, max_value=10.0))
                            )
                print(f"\tSuccessfully created or updated Dish: {dish}, {dish.image}\n")

    if DishReview in models_to_update:
        print("________________________________________________________________")
        print("DISH REVIEWS:")
        user_list = list(User.objects.all())
        load_intermediate_model(
            model_class=DishReview,
            primary_field='dish',
            related_field='user',
            primary_objects=dish_list,
            related_objects=user_list,
            max_items=max_reviews_per_dish,
            attributes={
                'rating': lambda: fake.random_int(min=1, max=5),
                'title': lambda: fake.sentence(nb_words=6),
                'content': lambda: fake.text(max_nb_chars=200)
            },
            action=action
        )

    if DishReviewLike in models_to_update:
        print("________________________________________________________________")
        print("DISH REVIEW LIKES:")
        user_list = list(User.objects.all())
        review_list = map_queryset.get(DishReview)
        load_intermediate_model(
            model_class=DishReviewLike,
            primary_field='review',
            related_field='user',
            primary_objects=review_list,
            related_objects=user_list,
            max_items=max_review_likes_per_dish,
            action=action,
        )

    if DishLike in models_to_update:
        print("________________________________________________________________")
        print("DISH LIKES:")
        user_list = list(User.objects.all())
        dish_list = map_queryset.get(Dish)
        load_intermediate_model(
            model_class=DishLike,
            primary_field='dish',
            related_field='user',
            primary_objects=dish_list,
            related_objects=user_list,
            max_items=max_likes_per_dish,
            action=action,
        )


def run(*args):
    if len(args) > 0:
        action = args[0]
        models = args[1:] if len(args) > 1 else []
        load_food(action=action, models_to_update=models)
    else:
        load_food()


# """
# follow my instruction when i run the script if no arguments are specified it will run all
# the first argument will be update or update_with_del if update_with_del it will delete data in that model
# the second argument specifies which model you can load that model and lowercase to match the argument
# if no attributes are specified it will update all else that specific argument
# each model which need the result of previous will list(Model.objects.all())
# (you see the arguments in a model in a dict you split to validate if the attribute argument
# update each case will just delete that model
# if update attribute it will not delete)

# modify this no attribute argument just model argument
# if no arguments specified will delete all models and load again
# else if first argument is update and no second argument is update it will not delete instead it update all models
# else if first argument is update and second argument is (can be list model) it will not delete that model instead it update
# else if first argument is delete and second argument (can be list model) it will delete those models 
# """