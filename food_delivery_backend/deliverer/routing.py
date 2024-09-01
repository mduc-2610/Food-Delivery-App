from django.urls import re_path
from deliverer.consumers import DelivererConsumer

websocket_urlpatterns = [
    re_path(r'ws/deliverer/(?P<deliverer_id>[\w-]+)/$', DelivererConsumer.as_asgi()),
]