import json
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.db import database_sync_to_async
from django.core.exceptions import ObjectDoesNotExist
from deliverer.models import Deliverer

class DelivererConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.deliverer_id = self.scope['url_route']['kwargs']['deliverer_id']
        self.room_name = f"deliverer_{self.deliverer_id}"

        await self.channel_layer.group_add(
            self.room_name,
            self.channel_name,
        )
        
        await self.accept()
        await self.set_deliverer_active_status(True)


    async def disconnect(self, close_code):
        await self.set_deliverer_active_status(False)
        await self.channel_layer.group_discard(
            self.room_name,
            self.channel_name
        )

    async def receive(self, text_data):
        if not text_data:
            print("Received empty content or non-JSON data")
            return

        try:
            text_data_json = json.loads(text_data)
            print(text_data_json, pretty=True)
        except json.JSONDecodeError:
            print("Failed to decode JSON")
            return
        
        await self.channel_layer.group_send(
            self.room_name,
            {
                'type': 'receive_delivery_request',
                "message": text_data_json
            }
        )

    async def send_to_deliverer(self, event):
        message = event['message']
        await self.send(text_data=json.dumps({
            'delivery': message.get('delivery'),
            'nearest_deliverer': message.get('nearest_deliverer'),
        }))

    async def receive_delivery_request(self, event):
        message = event['message']
        print(message)
        await self.send(text_data=json.dumps({
            'message': message,
        }))

    @database_sync_to_async
    def set_deliverer_active_status(self, is_active):
        try:
            deliverer = Deliverer.objects.get(id=self.deliverer_id)
            deliverer.is_active = is_active
            deliverer.save()
            print(deliverer, pretty=True)
        except Deliverer.DoesNotExist:
            print(f"Deliverer with ID {self.deliverer_id} does not exist.")
