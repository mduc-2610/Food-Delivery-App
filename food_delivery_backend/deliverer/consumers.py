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
        print(text_data_json.get('coordinate'), pretty=True)
        
        await self.channel_layer.group_send(
            self.room_name,
            {
                'type': 'receive_delivery_request',
                "message": text_data_json
            }
        )
        delivery = text_data_json.get('delivery')
        
        if delivery:
            delivery['deliverer'] = self.deliverer_id
        await self.channel_layer.group_send(
            f'order',
            {
                'type': 'tracking_request',
                'message': delivery
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
        await self.send(text_data=json.dumps({
            'message': message,
            'tracking_stage': message.get('tracking_stage')
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

    @database_sync_to_async
    def get_deliverer(self):
        try:
            deliverer = Deliverer.objects.get(id=self.deliverer_id)
            from deliverer.serializers import BasicDelivererSerializer
            serializer = BasicDelivererSerializer(deliverer)  
            return serializer.data
        except Deliverer.DoesNotExist:
            print(f"Deliverer with ID {self.deliverer_id} does not exist.")
            return None
        
    # def get_tracking_stage(self, message):
    #     from utils.objects import Point, Distance
    #     pickup_coordinate = message.get('pickup_coordinate')
    #     dropoff_coordinate = message.get('dropoff_coordinate')
    #     if pickup_coordinate and dropoff_coordinate:
    #         pickup_point = Point(*pickup_coordinate)
    #         dropoff_point = Point(*dropoff_coordinate)
    #         deliverer_point = Point(*message.get('coordinate'))
    #         x = 0
    #         if Distance.haversine(deliverer_point, pickup_point) <= 0.5:
    #             x = 1
    #             return 1  
    #         elif Distance.haversine(deliverer_point, dropoff_point) <= 0.5:
    #             x = 2
    #             return 2  
    #         print('to pickup', Distance.haversine(deliverer_point, pickup_point), 'to dropoff', Distance.haversine(deliverer_point, dropoff_point), 'tracking_stage', x,  pretty=True)
    #         return 0  
    #     return "NO data"

#     import json
# from channels.generic.websocket import AsyncWebsocketConsumer
# from channels.db import database_sync_to_async
# from django.core.exceptions import ObjectDoesNotExist
# from deliverer.models import Deliverer
# from utils.objects import Point, Distance

# class DelivererConsumer(AsyncWebsocketConsumer):
#     async def connect(self):
#         self.deliverer_id = self.scope['url_route']['kwargs']['deliverer_id']
#         self.room_name = f"deliverer_{self.deliverer_id}"

#         await self.channel_layer.group_add(
#             self.room_name,
#             self.channel_name,
#         )
        
#         await self.accept()
#         await self.set_deliverer_active_status(True)


#     async def disconnect(self, close_code):
#         await self.set_deliverer_active_status(False)
#         await self.channel_layer.group_discard(
#             self.room_name,
#             self.channel_name
#         )

#     async def receive(self, text_data):
#         if not text_data:
#             print("Received empty content or non-JSON data")
#             return

#         try:
#             text_data_json = json.loads(text_data)
#             print(text_data_json, pretty=True)
#         except json.JSONDecodeError:
#             print("Failed to decode JSON")
#             return
#         # print(text_data_json.get('current_coordinate'), pretty=True)
#         print(text_data_json, pretty=True)
#         await self.channel_layer.group_send(
#             self.room_name,
#             {
#                 'type': 'receive_delivery_request',
#                 "message": text_data_json
#             }
#         )
#         delivery = text_data_json.get('delivery')
        
#         if delivery:
#             delivery['deliverer'] = self.deliverer_id
#         await self.channel_layer.group_send(
#             f'order',
#             {
#                 'type': 'tracking_request',
#                 'message': delivery
#             }
#         )

#     async def send_to_deliverer(self, event):
#         message = event['message']
#         await self.send(text_data=json.dumps({
#             'delivery': message.get('delivery'),
#             'nearest_deliverer': message.get('nearest_deliverer'),
#         }))

#     async def receive_delivery_request(self, event):
#         message = event['message']
#         print(message.get('current_coordinate'), pretty=True)
#         await self.send(text_data=json.dumps({
#             'current_coordinate': message.get('current_coordinate'),
#             'tracking_stage': self.get_tracking_stage(message)
#         }))

#     @database_sync_to_async
#     def set_deliverer_active_status(self, is_active):
#         try:
#             deliverer = Deliverer.objects.get(id=self.deliverer_id)
#             deliverer.is_active = is_active
#             deliverer.save()
#             print(deliverer, pretty=True)
#         except Deliverer.DoesNotExist:
#             print(f"Deliverer with ID {self.deliverer_id} does not exist.")

#     def get_tracking_stage(self, message):
#         pickup_point = Point(*message.get('pickup_coordinate'))
#         dropoff_point = Point(*message.get('dropoff_coordinate'))
#         deliverer_point = Point(*message.get('current_coordinate'))

#         if Distance.haversine(deliverer_point, pickup_point) <= 500:
#             return 1  
#         elif Distance.haversine(deliverer_point, dropoff_point) <= 500:
#             return 2  
#         return 0  