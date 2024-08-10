# """
# ASGI config for food_delivery_backend project.

# It exposes the ASGI callable as a module-level variable named ``application``.

# For more information on this file, see
# https://docs.djangoproject.com/en/5.0/howto/deployment/asgi/
# """

# import os

# from django.core.asgi import get_asgi_application
# from channels.routing import ProtocolTypeRouter, URLRouter
# from channels.security.websocket import AllowedHostsOriginValidator
# from django_channels_jwt_auth_middleware.auth import JWTAuthMiddlewareStack
# import notification.routing

# os.environ.setdefault("DJANGO_SETTINGS_MODULE", "food_delivery_backend.settings")

# django_asgi_app = get_asgi_application()

# application = ProtocolTypeRouter({
#     'http': django_asgi_app,
#     'websocket': AllowedHostsOriginValidator(
#         JWTAuthMiddlewareStack(
#             URLRouter(
#                 notification.routing.websocket_urlpatterns
#             )
#         )
#     )
# })


import os
from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLRouter
from django.core.asgi import get_asgi_application
import notification.routing

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')

application = ProtocolTypeRouter({
    "http": get_asgi_application(),
    "websocket": AuthMiddlewareStack(
        URLRouter(
            notification.routing.websocket_urlpatterns
        )
    ),
})
