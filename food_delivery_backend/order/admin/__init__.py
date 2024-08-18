from django.contrib import admin

from .cart import RestaurantCartAdmin, RestaurantCartDishAdmin
from .delivery import DeliveryAdmin
from .order import OrderAdmin
from .owned_promotion import OrderPromotionAdmin, RestaurantPromotionAdmin, UserPromotionAdmin

from order.models import (
    RestaurantCart, RestaurantCartDish,
    Delivery,
    Order,
    OrderPromotion, RestaurantPromotion, UserPromotion
)

admin.site.register(RestaurantCart, RestaurantCartAdmin)
admin.site.register(RestaurantCartDish, RestaurantCartDishAdmin)
admin.site.register(Delivery, DeliveryAdmin)
admin.site.register(Order, OrderAdmin)
admin.site.register(OrderPromotion, OrderPromotionAdmin)
admin.site.register(RestaurantPromotion, RestaurantPromotionAdmin)
admin.site.register(UserPromotion, UserPromotionAdmin)
