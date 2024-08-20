from django.contrib import admin

from .option import DishOptionAdmin, DishOptionItemAdmin
from .category import DishCategoryAdmin
from .dish_like import DishLikeAdmin
from .dish import DishAdmin

from food.models import (
    DishOption, DishOptionItem,
    DishCategory,
    DishLike,
    Dish
)

admin.site.register(DishOption, DishOptionAdmin)
admin.site.register(DishOptionItem, DishOptionItemAdmin)
admin.site.register(DishCategory, DishCategoryAdmin)
admin.site.register(DishLike, DishLikeAdmin)
admin.site.register(Dish, DishAdmin)
