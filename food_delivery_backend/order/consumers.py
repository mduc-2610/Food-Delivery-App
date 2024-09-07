import json
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.layers import get_channel_layer
from channels.db import database_sync_to_async
from deliverer.models import Deliverer
from order.models import Delivery, DeliveryRequest
from utils.objects import Point, Distance

class OrderConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_name = 'order'

        await self.channel_layer.group_add(
            self.room_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(
            self.room_name,
            self.channel_name
        )

    async def receive(self, text_data):
        try:
            text_data_json = json.loads(text_data)
            print(text_data_json, pretty=True)
            delivery = text_data_json.get('delivery')
            nearest_deliverer = text_data_json.get('nearest_deliverer')
            print(delivery, pretty=True)
            print(nearest_deliverer, pretty=True)
            await self.channel_layer.group_send(
                f"deliverer_{nearest_deliverer['id']}",
                {
                    'type': 'send_to_deliverer',
                    'message': {
                        'delivery': delivery,
                        'nearest_deliverer': nearest_deliverer
                    }
                }
            )
        except json.JSONDecodeError:
            print("Failed to decode JSON")
            return

    async def send_to_deliverer(self, event):
        message = event['message']
        await self.send(text_data=json.dumps({
            'delivery': message.get('delivery'),
            'nearest_deliverer': message.get('nearest_deliverer'),
        }))

    async def tracking_request(self, event):
        message = event['message']
        await self.send(text_data=json.dumps({
            'delivery': message,
        }))
