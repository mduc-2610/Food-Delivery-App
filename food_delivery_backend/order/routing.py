from django.urls import path
from order.consumer import OrderConsumer

websocket_urlpatterns = [
    path('ws/order/', OrderConsumer.as_asgi()),
]