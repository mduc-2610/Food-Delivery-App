import json
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.db import database_sync_to_async
from django.core.exceptions import ObjectDoesNotExist
from deliverer.models import Deliverer
from utils.objects import Point, Distance

class DelivererConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.deliverer_id = self.scope['url_route']['kwargs']['deliverer_id']
        self.room_name = f"deliverer_{self.deliverer_id}"

        await self.channel_layer.group_add(self.room_name, self.channel_name)
        await self.accept()

        await self.set_deliverer_active_status(True)

    async def disconnect(self, close_code):
        await self.set_deliverer_active_status(False)
        
        await self.channel_layer.group_discard(self.room_name, self.channel_name)

    async def receive(self, text_data):
        if not text_data:
            print("Received empty content or non-JSON data")
            return

        try:
            text_data_json = json.loads(text_data)
        except json.JSONDecodeError:
            print("Failed to decode JSON")
            return

        coordinate = text_data_json.get('coordinate')
        delivery_request = text_data_json.get('delivery_request')

        if delivery_request:
            delivery_request['delivery']['deliverer'] = self.deliverer_id

        if coordinate:
            await self.channel_layer.group_send(
                self.room_name,
                {
                    'type': 'tracking_request',
                    "message": text_data_json
                }
            )
        else:
            await self._broadcast_delivery_request(delivery_request)

    async def _broadcast_delivery_request(self, delivery_request):
        if not delivery_request:
            print("Empty delivery request")
            return
        
        for group in [self.room_name, 'order']:
            await self.channel_layer.group_send(
                group,
                {
                    'type': 'receive_delivery_request',
                    'message': delivery_request
                }
            )

    async def receive_delivery_request(self, event):
        delivery_request = event['message']
        await self.send(text_data=json.dumps({
            'delivery_request': delivery_request,
        }))

    async def tracking_request(self, event):
        message = event['message']
        print('Polyline index', message.get('polyline_index'), pretty=True)
        await self.send(text_data=json.dumps({
            'message': message,
            'tracking_stage': message.get('tracking_stage'),
            # 'polyline_index': message.get('polyline_index'),
        }))

    @database_sync_to_async
    def set_deliverer_active_status(self, is_active):
        try:
            deliverer = Deliverer.objects.get(id=self.deliverer_id)
            deliverer.is_active = is_active
            deliverer.save()
            print(f"Deliverer {self.deliverer_id} is_active={is_active}")
        except Deliverer.DoesNotExist:
            print(f"Deliverer with ID {self.deliverer_id} does not exist.")

    def get_tracking_stage(self, message):
        """
        Determines the tracking stage based on deliverer's proximity to pickup and dropoff points.
        """
        pickup_coordinate = message.get('pickup_coordinate')
        dropoff_coordinate = message.get('dropoff_coordinate')
        deliverer_coordinate = message.get('coordinate')

        if pickup_coordinate and dropoff_coordinate and deliverer_coordinate:
            pickup_point = Point(*pickup_coordinate)
            dropoff_point = Point(*dropoff_coordinate)
            deliverer_point = Point(*deliverer_coordinate)

            if Distance.haversine(deliverer_point, pickup_point) <= 0.5:
                return 1  
            elif Distance.haversine(deliverer_point, dropoff_point) <= 0.5:
                return 2  
        return 0  