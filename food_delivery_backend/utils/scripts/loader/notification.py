import random
from faker import Faker

from django.utils import timezone
from django.db import transaction

from account.models import User
from notification.models import (
    DirectRoom, GroupRoom, 
    DirectImageMessage, GroupImageMessage,
    DirectVideoMessage, GroupVideoMessage,
    DirectMessage, GroupMessage,
    UserNotification, Notification, 
)

from utils.function import load_intermediate_model, load_one_to_many_model
from django.db import transaction

fake = Faker()

@transaction.atomic
def load_notification(
        max_notifications=50, 
        max_messages=200,
        max_user_notifications=30,
        max_group_users=20,
        max_direct_rooms=80, 
        max_group_rooms=50,
        max_direct_messages=1000,
        max_group_messages=1500,

        max_video_per_messages=2,
        max_immage_per_messages=10
    ):
    model_list = [
        DirectRoom, GroupRoom, 
        DirectMessage, GroupMessage,
        UserNotification, Notification, 
    ]
    
    for model in model_list:
        model.objects.all().delete()

    user_list = list(User.objects.all())
    
    print("________________________________________________________________")
    print("NOTIFICATIONS:")
    notification_list = []
    for _ in range(max_notifications):
        notification_data = {
            "notification_type": fake.random_element(elements=('DISCOUNT', 'ORDER', 'ACCOUNT')),
            "title": fake.sentence(nb_words=6),
            "description": fake.text(max_nb_chars=200)
        }
        notification = Notification.objects.create(**notification_data)
        notification_list.append(notification)
        print(f"\tSuccessfully created Notification: {notification}")

    print("________________________________________________________________")
    print("USER NOTIFICATIONS:")
    load_intermediate_model(
        model_class=UserNotification,
        primary_field='user',
        related_field='notification',
        primary_objects=user_list,
        related_objects=notification_list,
        max_items=max_user_notifications
    )

    # print("________________________________________________________________")
    # print("DIRECT ROOMS:")
    # direct_room_list = []
    # for _ in range(max_direct_rooms):
    #     user1, user2 = random.sample(user_list, 2)
    #     direct_room_data = {
    #         "name": f"{user1.username} - {user2.username}",
    #         "user1": user1,
    #         "user2": user2
    #     }
    #     direct_room = DirectRoom.objects.create(**direct_room_data)
    #     direct_room_list.append(direct_room)
    #     print(f"\tSuccessfully created Direct Room: {direct_room}")
    
    print("________________________________________________________________")
    print("DIRECT ROOMS:")
    load_intermediate_model(
        model_class=DirectRoom,
        primary_field='user1',
        related_field='user2',
        primary_objects=user_list,
        related_objects=user_list,
        max_items=20,
        attributes={}
    )

    print("________________________________________________________________")
    print("GROUP ROOMS:")
    group_room_list = []
    for _ in range(max_group_rooms):
        group_room_data = {
            "name": fake.sentence(nb_words=4),
        }
        group_room = GroupRoom.objects.create(**group_room_data)
        tmp = user_list.copy()
        group_room.members.add(*[tmp.pop(random.randint(0, len(tmp) - 1)) for i in range(random.randint(3, max_group_users))])
        group_room_list.append(group_room)
        print(f"\tSuccessfully created Group Room: {group_room}")

    print("________________________________________________________________")
    print("DIRECT MESSAGES:")
    direct_message_list = []
    for _ in range(max_direct_messages):
        sender, receiver = random.sample(user_list, 2)
        direct_room = DirectRoom.objects.filter(user1=sender, user2=receiver).first() or \
            DirectRoom.objects.filter(user1=receiver, user2=sender).first()
        have_location_message = random.choice([True, False, False, True, False, False, False])
        direct_message_data = {
            "user": sender,
            "room": direct_room,
            "content": fake.text(max_nb_chars=200) if not have_location_message else None,
            "latitude": fake.latitude() if have_location_message else None,
            "longitude": fake.longitude() if have_location_message else None,
            "created_at": timezone.now()
        }
        direct_message = DirectMessage.objects.create(**direct_message_data)
        direct_message_list.append(direct_message)
        print(f"\tSuccessfully created Direct Message: {direct_message}")

    print("________________________________________________________________")
    print("GROUP MESSAGES:")
    group_message_list = []
    for _ in range(max_group_messages):
        sender = random.choice(user_list)
        group_room = random.choice(group_room_list)
        have_location_message = random.choice([True, False, False, True, False, False, False])
        group_message_data = {
            "user": sender,
            "room": group_room,
            "content": fake.text(max_nb_chars=200) if not have_location_message else None,
            "latitude": fake.latitude() if have_location_message else None,
            "longitude": fake.longitude() if have_location_message else None,
            "created_at": timezone.now()
        }
        group_message = GroupMessage.objects.create(**group_message_data)
        group_message_list.append(group_message)
        print(f"\tSuccessfully created Group Message: {group_message}")
    
    print("________________________________________________________________")
    print("DIRECT IMAGE MESSGAGE: ")
    load_one_to_many_model(
        model_class=DirectImageMessage,
        primary_field='message',
        primary_objects=direct_message_list,
        max_related_objects=10,
        attributes={
            'image': lambda: fake.image_url()
        }
    )

    print("________________________________________________________________")
    print("GROUP IMAGE MESSGAGE: ")
    load_one_to_many_model(
        model_class=GroupImageMessage,
        primary_field='message',
        primary_objects=group_message_list,
        max_related_objects=10,
        attributes={
            'image': lambda: fake.image_url()
        }
    )


    print("________________________________________________________________")
    print("DIRECT VIDEO MESSGAGE: ")
    load_one_to_many_model(
        model_class=DirectVideoMessage,
        primary_field='message',
        primary_objects=direct_message_list,
        max_related_objects=10,
        attributes={
            'video': lambda: fake.image_url()
        }
    )

    print("________________________________________________________________")
    print("GROUP VIDEO MESSAGE")
    load_one_to_many_model(
        model_class=GroupVideoMessage,
        primary_field='message',
        primary_objects=group_message_list,
        max_related_objects=10,
        attributes={
            'video': lambda: fake.image_url()
        }
    )