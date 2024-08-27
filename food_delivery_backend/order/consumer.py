import json
from channels.generic.websocket import AsyncWebsocketConsumer
from order.serializers import OrderSerializer  

class OrderConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_group_name = 'order'

        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'update_room_lists',
                'order': text_data_json
            }
        )
        # else:
        #     pass

    async def update_room_lists(self, event):
        order = event['order']
        print(order, pretty=True)
        await self.send(text_data=json.dumps({
            'order': order,
        }))
