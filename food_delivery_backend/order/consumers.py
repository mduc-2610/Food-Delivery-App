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
            # print(text_data_json, pretty=True)
            # print(delivery, pretty=True)
            # print(nearest_deliverer, pretty=True)
            
            flag = text_data_json.get('flag')
            deliverer_id = text_data_json.get('deliverer_id')
            delivery_request = text_data_json.get('delivery_request')
            nearest_deliverer = text_data_json.get('nearest_deliverer')

            print('FLAG: ', flag, deliverer_id, pretty=True)
            await self.channel_layer.group_send(
                f"deliverer_{deliverer_id}",
                {
                    'type': 'notify_new_request',
                    'message': {
                        'flag': flag,
                        'delivery_request': delivery_request,
                        'nearest_deliverer': nearest_deliverer,
                    }
                }
            )
            

        except json.JSONDecodeError:
            print("Failed to decode JSON")
            return
    
    async def notify_new_request(self, event):
        message = event['message']
        print("RECEIVE FLAG2: ", message.get('flag'), pretty=True)
        await self.send(text_data=json.dumps({
            'flag': message.get('flag'),
            'delivery_request': message.get('delivery_request'),
            'nearest_deliverer': message.get('nearest_deliverer'),
        }))

    # async def send_to_deliverer(self, event):
    #     message = event['message']
    #     await self.send(text_data=json.dumps({
    #         'delivery': message.get('delivery'),
    #         'nearest_deliverer': message.get('nearest_deliverer'),
    #     }))
    

    async def receive_delivery_request(self, event):
        delivery_request = event['message']
        print("Received delivery request", delivery_request, pretty=True)
        await self.send(text_data=json.dumps({
            'delivery_request': delivery_request,
        }))
