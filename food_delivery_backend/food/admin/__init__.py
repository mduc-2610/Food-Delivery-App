from django.contrib import admin

from .addition import DishAdditionalOptionAdmin
from .category import DishCategoryAdmin
from .dish_like import DishLikeAdmin
from .dish import DishAdmin

from food.models import (
    DishAdditionalOption,
    DishCategory,
    DishLike,
    Dish
)

admin.site.register(DishAdditionalOption, DishAdditionalOptionAdmin)
admin.site.register(DishCategory, DishCategoryAdmin)
admin.site.register(DishLike, DishLikeAdmin)
admin.site.register(Dish, DishAdmin)
