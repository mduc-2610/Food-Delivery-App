from django.contrib import admin

from .address import AddressAdmin
from .basic_info import BasicInfoAdmin
from .deliverer import DelivererAdmin
from .driver_license import DriverLicenseAdmin
from .emergency_contact import EmergencyContactAdmin
from .operation_info import OperationInfoAdmin
from .other_info import OtherInfoAdmin
from .residency_info import ResidencyInfoAdmin

from deliverer.models import (
    Address,
    BasicInfo,
    Deliverer,
    DriverLicense,
    EmergencyContact,
    OperationInfo,
    OtherInfo,
    ResidencyInfo
)

admin.site.register(Address, AddressAdmin)
admin.site.register(BasicInfo, BasicInfoAdmin)
admin.site.register(Deliverer, DelivererAdmin)
admin.site.register(DriverLicense, DriverLicenseAdmin)
admin.site.register(EmergencyContact, EmergencyContactAdmin)
admin.site.register(OperationInfo, OperationInfoAdmin)
admin.site.register(OtherInfo, OtherInfoAdmin)
admin.site.register(ResidencyInfo, ResidencyInfoAdmin)
