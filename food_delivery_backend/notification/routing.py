from django.urls import path, re_path
from notification.consumer import ChatConsumer, RoomListConsumer

websocket_urlpatterns = [
    re_path(r'ws/chat/(?P<room_name>[\w-]+)/$', ChatConsumer.as_asgi()),
    re_path(r'ws/chat/', RoomListConsumer.as_asgi()),
]
