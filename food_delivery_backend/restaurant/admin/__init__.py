from django.contrib import admin

from .basic_info import BasicInfoAdmin
from .detail_info import DetailInfoAdmin
from .menu_delivery import MenuDeliveryAdmin
from .operating_hour import OperatingHourAdmin
from .representative_info import RepresentativeInfoAdmin
from .restaurant import RestaurantAdmin, RestaurantCategoryAdmin

from restaurant.models import (
    BasicInfo, 
    DetailInfo,
    MenuDelivery,
    OperatingHour,
    RepresentativeInfo,
    Restaurant, RestaurantCategory
)

admin.site.register(BasicInfo, BasicInfoAdmin)
admin.site.register(DetailInfo, DetailInfoAdmin)
admin.site.register(MenuDelivery, MenuDeliveryAdmin)
admin.site.register(OperatingHour, OperatingHourAdmin)
admin.site.register(RepresentativeInfo, RepresentativeInfoAdmin)
admin.site.register(Restaurant, RestaurantAdmin)
admin.site.register(RestaurantCategory, RestaurantCategoryAdmin)
