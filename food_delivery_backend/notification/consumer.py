# chat/consumers.py

import json
from rest_framework import exceptions
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.db import database_sync_to_async

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = f'chat_{self.room_name}'

        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    @database_sync_to_async
    def get_message_from_db(self, message):
        from notification.models import DirectMessage
        from notification.serializers import DirectMessageSerializer
        print(type(message), message,pretty=True)
        return DirectMessageSerializer(
            message
            ).data

    async def receive(self, text_data):
        if not text_data:
            print("Received empty content or non-JSON data")
            return

        try:
            text_data_json = json.loads(text_data)
        except json.JSONDecodeError:
            print("Failed to decode JSON")
            return
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'chat_content',
                "message": text_data_json
            }
        )

    async def chat_content(self, event):
        message = event['message']
        print(message)
        await self.send(text_data=json.dumps({
            'message': message,
        }))



class RoomListConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_group_name = 'room_list'

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
        if not text_data:
            print("Received empty content or non-JSON data")
            return

        try:
            text_data_json = json.loads(text_data)
        except json.JSONDecodeError:
            print("Failed to decode JSON")
            return
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'update_room_lists',
                "message": text_data_json
            }
        )

    async def update_room_lists(self, event):
        message = event['message']
        print(message)
        await self.send(text_data=json.dumps({
            'message': message,
        }))