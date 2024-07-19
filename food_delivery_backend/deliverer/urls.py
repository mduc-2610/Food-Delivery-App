# addresses/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from deliverer.views import (
    AddressViewSet,
    BasicInfoViewSet,
    DelivererViewSet,
    DriverLicenseViewSet,
    EmergencyContactViewSet,
    OperationInfoViewSet,
    OtherInfoViewSet,
    ResidencyInfoViewSet
)

router = DefaultRouter()
router.register(r'addresses', AddressViewSet)
router.register(r'basicinfo', BasicInfoViewSet)
router.register(r'deliverers', DelivererViewSet)
router.register(r'driver-licenses', DriverLicenseViewSet)
router.register(r'emergency-contacts', EmergencyContactViewSet)
router.register(r'operation-info', OperationInfoViewSet)
router.register(r'other-info', OtherInfoViewSet)
router.register(r'residency-info', ResidencyInfoViewSet)

urlpatterns = [
]

urlpatterns += router.urls