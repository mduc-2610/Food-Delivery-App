from django.contrib import admin

from .basic_info import BasicInfoAdmin
from .detail_information import DetailInformationAdmin
from .menu_delivery import MenuDeliveryAdmin
from .operating_hour import OperatingHourAdmin
from .representative import RepresentativeAdmin
from .restaurant import RestaurantAdmin

from restaurant.models import (
    BasicInfo, 
    DetailInformation,
    MenuDelivery,
    OperatingHour,
    Representative,
    Restaurant
)

admin.site.register(BasicInfo, BasicInfoAdmin)
admin.site.register(DetailInformation, DetailInformationAdmin)
admin.site.register(MenuDelivery, MenuDeliveryAdmin)
admin.site.register(OperatingHour, OperatingHourAdmin)
admin.site.register(Representative, RepresentativeAdmin)
admin.site.register(Restaurant, RestaurantAdmin)
