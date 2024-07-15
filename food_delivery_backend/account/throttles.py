
from rest_framework.throttling import SimpleRateThrottle
from utils.throttles import CustomThrottle

class OTPThrottle(CustomThrottle):
    scope = 'otp'

