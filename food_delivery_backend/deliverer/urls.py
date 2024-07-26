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
router.register(r'address', AddressViewSet)
router.register(r'basic-info', BasicInfoViewSet)
router.register(r'deliverer', DelivererViewSet)
router.register(r'driver-license', DriverLicenseViewSet)
router.register(r'emergency-contact', EmergencyContactViewSet)
router.register(r'operation-info', OperationInfoViewSet)
router.register(r'other-info', OtherInfoViewSet)
router.register(r'residency-info', ResidencyInfoViewSet)

urlpatterns = [
]

urlpatterns += router.urls