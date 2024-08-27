# import random, os, sys
# from faker import Faker
# from django.conf import settings
# from django.db import transaction
# from account.models import User
# from food.models import (
#     Dish, DishLike, 
#     DishCategory, DishOption, DishOptionItem
# )
# from restaurant.models import Restaurant
# from review.models import DishReview, DishReviewLike
# from utils.function import load_intermediate_model
# from utils.scripts.data import dish_categories, category_options

# fake = Faker()

# def delete_model_data(model, update_mode):
#     if update_mode == 'update_with_del':
#         model.objects.all().delete()
#     elif update_mode == 'update':
#         pass  

# @transaction.atomic
# def load_food(
#     update_mode='update',
#     model_to_update=None,
#     attribute_to_update=None,
#     max_categories=30, 
#     max_dishes=150,
#     max_dish_likes=50,
#     max_dish_reviews=25,
#     max_dish_reviews_like=25,
# ):
#     model_list = [
#         Dish, DishLike, 
#         DishCategory, DishOption, DishOptionItem,
#         DishReview, DishReviewLike
#     ]

#     if model_to_update:
#         model_list = [globals()[model_to_update.capitalize()]]

#     for model in model_list:
#         delete_model_data(model, update_mode)

#     user_list = list(User.objects.all())
#     restaurant_list = list(Restaurant.objects.all())

#     if not model_to_update or model_to_update == 'dishcategory':
#         print("________________________________________________________________")
#         print("DISH CATEGORIES:")
#         category_list = load_dish_categories(attribute_to_update)
#     else:
#         category_list = list(DishCategory.objects.all())

#     if not model_to_update or model_to_update == 'dish':
#         print("________________________________________________________________")
#         print("DISHES:")
#         dish_list = load_dishes(category_list, max_dishes, attribute_to_update)
#     else:
#         dish_list = list(Dish.objects.all())

#     if not model_to_update or model_to_update == 'dishreview':
#         print("________________________________________________________________")
#         print("DISH REVIEWS:")
#         review_list = load_dish_reviews(dish_list, user_list, max_dish_reviews, attribute_to_update)
#     else:
#         review_list = list(DishReview.objects.all())

#     if not model_to_update or model_to_update == 'dishreviewlike':
#         print("________________________________________________________________")
#         print("DISH REVIEW LIKES:")
#         load_dish_review_likes(review_list, user_list, max_dish_reviews_like)

#     if not model_to_update or model_to_update == 'dishlike':
#         print("________________________________________________________________")
#         print("DISH LIKES:")
#         load_dish_likes(dish_list, user_list, max_dish_likes)

#     return dish_list

# def load_dish_categories(attribute_to_update):
#     category_list = []
#     for x in dish_categories:
#         category_data = {
#             "name": x.get('name'),
#             "description": x.get('description', fake.text(max_nb_chars=200)),
#             "image": x.get('image'),
#         }
#         if attribute_to_update and attribute_to_update != 'all':
#             category, _ = DishCategory.objects.update_or_create(
#                 name=category_data['name'],
#                 defaults={attribute_to_update: category_data[attribute_to_update]}
#             )
#         else:
#             category, _ = DishCategory.objects.update_or_create(
#                 name=category_data['name'],
#                 defaults=category_data
#             )
#         category_list.append(category)
#         print(f"\tSuccessfully created/updated Dish Category: {category}")
#     return category_list

# def load_dishes(category_list, max_dishes, attribute_to_update):
#     dish_list = []
#     for category in category_list:
#         category_name = category.name.lower().replace(' ', '_')
#         category_folder_path = os.path.join(settings.MEDIA_ROOT, f"food/{category_name}")

#         if not os.path.exists(category_folder_path):
#             print(f"Category folder not found: {category_folder_path}")
#             continue

#         tmp = os.listdir(category_folder_path).copy()

#         for i, image_file in enumerate(os.listdir(category_folder_path)):
#             if i >= max_dishes:
#                 break

#             dish_data = {
#                 "name": category.name + ' ' + fake.word() + ' ' + fake.word(),
#                 "description": fake.text(max_nb_chars=200),
#                 "original_price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=10, max_value=100),
#                 "discount_price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
#                 "category": category,
#                 "image": f"food/{category_name}/{tmp.pop(random.randint(0, len(tmp) - 1))}",
#             }

#             if attribute_to_update and attribute_to_update != 'all':
#                 dish, created = Dish.objects.update_or_create(
#                     name=dish_data['name'],
#                     defaults={attribute_to_update: dish_data[attribute_to_update]}
#                 )
#             else:
#                 dish, created = Dish.objects.update_or_create(
#                     name=dish_data['name'],
#                     defaults=dish_data
#                 )

#             if category.name in category_options:
#                 load_dish_options(dish, category)

#             dish_list.append(dish)
#             print(f"\tSuccessfully created/updated Dish: {dish}, {dish.image}\n")
#     return dish_list

# def load_dish_options(dish, category):
#     options = category_options[category.name]
#     for option_type, option_list in options.items():
#         dish_option, _ = DishOption.objects.update_or_create(dish=dish, name=option_type)

#         for option_name in option_list:
#             DishOptionItem.objects.update_or_create(
#                 option=dish_option,
#                 name=option_name,
#                 price=float(fake.pydecimal(left_digits=1, right_digits=2, positive=True, min_value=0.5, max_value=10.0))
#             )

# def load_dish_reviews(dish_list, user_list, max_dish_reviews, attribute_to_update):
#     review_attributes = {
#         'rating': lambda: fake.random_int(min=1, max=5),
#         'title': lambda: fake.sentence(nb_words=6),
#         'content': lambda: fake.text(max_nb_chars=200)
#     }

#     if attribute_to_update and attribute_to_update != 'all':
#         review_attributes = {attribute_to_update: review_attributes[attribute_to_update]}

#     return load_intermediate_model(
#         model_class=DishReview,
#         primary_field='dish',
#         related_field='user',
#         primary_objects=dish_list,
#         related_objects=user_list,
#         max_items=max_dish_reviews,
#         attributes=review_attributes
#     )

# def load_dish_review_likes(review_list, user_list, max_dish_reviews_like):
#     load_intermediate_model(
#         model_class=DishReviewLike,
#         primary_field='review',
#         related_field='user',
#         primary_objects=review_list,
#         related_objects=user_list,
#         max_items=max_dish_reviews_like,
#     )

# def load_dish_likes(dish_list, user_list, max_dish_likes):
#     load_intermediate_model(
#         model_class=DishLike,
#         primary_field='dish',
#         related_field='user',
#         primary_objects=dish_list,
#         related_objects=user_list,
#         max_items=max_dish_likes,
#     )

# def run(*args):
#     update_mode = args[1] if len(args) > 1 else 'update'
#     model_to_update = args[2].lower() if len(args) > 2 else None
#     attribute_to_update = args[3] if len(args) > 3 else None

#     load_food(update_mode, model_to_update, attribute_to_update)

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
from restaurant.models import Restaurant
from review.models import DishReview, DishReviewLike

from utils.function import load_intermediate_model
from utils.scripts.data import dish_categories, category_options

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

@transaction.atomic
def load_food(
    max_categories=30, 
    max_dishes=150,
    max_dish_likes=50,
    max_dish_reviews=25,
    max_dish_reviews_like=25,
    models_to_update=None
):
    all_objects = {model: model.objects.all() for model in MODEL_MAP.values()}

    if models_to_update is None or models_to_update:
        if models_to_update:
            models_to_update_classes = [MODEL_MAP[m] for m in models_to_update if m in MODEL_MAP]
        else:
            models_to_update_classes = MODEL_MAP.values()

        if DishCategory in models_to_update_classes:
            print("________________________________________________________________")
            print("DISH CATEGORIES:")
            category_list = []
            for _x in dish_categories:
                category_data = {
                    "description": fake.word() + fake.text(max_nb_chars=200),
                    "image": _x.get('image'),
                }
                _category = None
                find = DishCategory.objects.filter(name=_x.get('name'))
                if not find.exists():
                    category_data.update({
                        'name': _x.get('name')
                    })
                    _category = DishCategory.objects.create(**category_data)
                    category_list.append(_category)
                else:
                    _category = find.first()
                    _category.description = category_data.get('description')
                    _category.image = category_data.get('image')
                    _category.save()
                    category_list.append(_category)
                print(f"\tSuccessfully created Dish Category: {_category}")

        if Dish in models_to_update_classes:
            print("________________________________________________________________")
            print("DISHES:")
            dish_list = []
            for category in category_list:
                category_name = category.name.lower().replace(' ', '_')
                category_folder_path = os.path.join(settings.MEDIA_ROOT, f"food/{category_name}")
                
                if not os.path.exists(category_folder_path):
                    print(f"Category folder not found: {category_folder_path}")
                    continue
                
                tmp = os.listdir(category_folder_path).copy()
                
                for i, image_file in enumerate(os.listdir(category_folder_path)):
                    if i >= max_dishes:
                        break
                    
                    dish_data = {
                        "name": category.name + ' ' + fake.word() + ' ' + fake.word(),
                        "description": fake.text(max_nb_chars=200),
                        "original_price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=10, max_value=100),
                        "discount_price": fake.pydecimal(left_digits=2, right_digits=2, positive=True, min_value=5, max_value=50),
                        "category": category,
                        "image": f"food/{category_name}/{tmp.pop(random.randint(0, len(tmp) - 1))}",
                    }
                    
                    dish, created = Dish.objects.update_or_create(**dish_data)
                    
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
                    
                    dish_list.append(dish)
                    print(f"\tSuccessfully created Dish: {dish}, {dish.image}\n")
            
        if DishReview in models_to_update_classes:
            print("________________________________________________________________")
            print("DISH REVIEWS:")
            review_attributes = {
                'rating': lambda: fake.random_int(min=1, max=5),
                'title': lambda: fake.sentence(nb_words=6),
                'content': lambda: fake.text(max_nb_chars=200)
            }
            user_list = User.objects.all()
            review_list = load_intermediate_model(
                model_class=DishReview,
                primary_field='dish',
                related_field='user',
                primary_objects=dish_list,
                related_objects=user_list,
                max_items=max_dish_reviews,
                attributes=review_attributes
            )

        if DishReviewLike in models_to_update_classes:
            print("________________________________________________________________")
            print("DISH REVIEW LIKES:")
            user_list = User.objects.all()
            review_list = all_objects.get(DishReview, [])
            load_intermediate_model(
                model_class=DishReviewLike,
                primary_field='review',
                related_field='user',
                primary_objects=review_list,
                related_objects=user_list,
                max_items=max_dish_reviews_like
            )
        
        if DishLike in models_to_update_classes:
            print("________________________________________________________________")
            print("DISH LIKES:")
            user_list = User.objects.all()
            dish_list = all_objects.get(Dish, [])
            load_intermediate_model(
                model_class=DishLike,
                primary_field='dish',
                related_field='user',
                primary_objects=dish_list,
                related_objects=user_list,
                max_items=max_dish_likes
            )

def delete_models(models_to_delete):
    for model in models_to_delete:
        model.objects.all().delete()

def run(*args):
    action = args[0] if args else None

    if action == 'delete':
        models_to_delete = args[1:] if len(args) > 1 else MODEL_MAP.keys()
        delete_models([MODEL_MAP[m] for m in models_to_delete if m in MODEL_MAP])
        models_to_update = args[1:] if len(args) > 1 else None
    elif action == 'update':
        models_to_update = args[1:] if len(args) > 1 else None
    else:
        models_to_update = None

    if models_to_update is not None or action is None:
        load_food(models_to_update=models_to_update)
    elif action not in ['delete', 'update']:
        print("Invalid action. Use 'delete' or 'update'.")
