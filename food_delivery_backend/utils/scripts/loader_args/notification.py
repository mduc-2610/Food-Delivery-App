import sys
import random
from faker import Faker
from django.db import transaction
from django.utils import timezone

from account.models import User
from notification.models import (
    DirectRoom, GroupRoom, 
    DirectImageMessage, GroupImageMessage,
    DirectVideoMessage, GroupVideoMessage,
    DirectMessage, GroupMessage,
    UserNotification, Notification, 
)
from utils.function import load_intermediate_model, load_one_to_many_model
from utils.decorators import script_runner

fake = Faker()

MODEL_MAP = {
    'direct_room': DirectRoom,
    'group_room': GroupRoom,
    'direct_message': DirectMessage,
    'group_message': GroupMessage,
    'user_notification': UserNotification,
    'notification': Notification,
    'direct_image_message': DirectImageMessage,
    'group_image_message': GroupImageMessage,
    'direct_video_message': DirectVideoMessage,
    'group_video_message': GroupVideoMessage
}

@script_runner(MODEL_MAP)
@transaction.atomic
def load_notification(
    max_notifications=50, 
    max_notifications_per_user=30,
    max_users_per_group=20,
    max_direct_rooms=80, 
    max_group_rooms=50,
    max_direct_messages_per_room=30,
    max_group_messages_per_room=20,
    max_videos_per_message=2,
    max_images_per_message=3,
    models_to_update=None,
    map_queryset=None,
    action=None,
):
    if Notification in models_to_update:
        print("________________________________________________________________")
        print("NOTIFICATIONS:")
        notification_list = [
            Notification.objects.create(
                notification_type=fake.random_element(elements=('DISCOUNT', 'ORDER', 'ACCOUNT')),
                title=fake.sentence(nb_words=6),
                description=fake.text(max_nb_chars=200)
            )
            for _ in range(max_notifications)
        ]
        print(f"\tSuccessfully created {len(notification_list)} Notifications.")
    
    if UserNotification in models_to_update:
        print("________________________________________________________________")
        print("USER NOTIFICATIONS:")
        load_intermediate_model(
            model_class=UserNotification,
            primary_field='user',
            related_field='notification',
            primary_objects=map_queryset.get(User),
            related_objects=map_queryset.get(Notification),
            max_items=max_notifications_per_user,
            action=action
        )

    if DirectRoom in models_to_update:
        print("________________________________________________________________")
        print("DIRECT ROOMS:")
        direct_room_list = load_intermediate_model(
            model_class=DirectRoom,
            primary_field='user1',
            related_field='user2',
            primary_objects=map_queryset.get(User),
            related_objects=map_queryset.get(User),
            max_items=max_direct_rooms,
            attributes={},
            action=action
        )
    else:
        direct_room_list = []

    if GroupRoom in models_to_update:
        print("________________________________________________________________")
        print("GROUP ROOMS:")
        group_room_list = [
            GroupRoom.objects.create(
                name=fake.sentence(nb_words=4)
            ) for _ in range(max_group_rooms)
        ]
        for group_room in group_room_list:
            tmp_users = list(map_queryset.get(User))
            group_room.members.add(*[tmp_users.pop(random.randint(0, len(tmp_users) - 1)) for _ in range(random.randint(3, max_users_per_group))])
        print(f"\tSuccessfully created {len(group_room_list)} Group Rooms.")
    else:
        group_room_list = []

    if DirectMessage in models_to_update:
        print("________________________________________________________________")
        print("DIRECT MESSAGES:")
        direct_message_list = [
            DirectMessage.objects.create(
                user=random.choice([direct_room.user1, direct_room.user2]),
                room=direct_room,
                content=fake.text(max_nb_chars=200) if not random.choice([True, False, False, True, False, False, False]) else None,
                latitude=fake.latitude() if random.choice([True, False, False, True, False, False, False]) else None,
                longitude=fake.longitude() if random.choice([True, False, False, True, False, False, False]) else None,
                created_at=timezone.now()
            )
            for direct_room in direct_room_list
            for _ in range(random.randint(1, max_direct_messages_per_room))
        ]
        print(f"\tSuccessfully created {len(direct_message_list)} Direct Messages.")
    else:
        direct_message_list = []

    if GroupMessage in models_to_update:
        print("________________________________________________________________")
        print("GROUP MESSAGES:")
        group_message_list = [
            GroupMessage.objects.create(
                user=random.choice(group_room.members.all()),
                room=group_room,
                content=fake.text(max_nb_chars=200) if not random.choice([True, False, False, True, False, False, False]) else None,
                latitude=fake.latitude() if random.choice([True, False, False, True, False, False, False]) else None,
                longitude=fake.longitude() if random.choice([True, False, False, True, False, False, False]) else None,
                created_at=timezone.now()
            )
            for group_room in group_room_list
            for _ in range(random.randint(0, max_group_messages_per_room))
        ]
        print(f"\tSuccessfully created {len(group_message_list)} Group Messages.")
    else:
        group_message_list = []

    if DirectImageMessage in models_to_update:
        print("________________________________________________________________")
        print("DIRECT IMAGE MESSAGES:")
        load_one_to_many_model(
            model_class=DirectImageMessage,
            primary_field='message',
            primary_objects=direct_message_list,
            max_related_objects=max_images_per_message,
            attributes={'image': lambda: fake.image_url()},
            action=action
        )

    if GroupImageMessage in models_to_update:
        print("________________________________________________________________")
        print("GROUP IMAGE MESSAGES:")
        load_one_to_many_model(
            model_class=GroupImageMessage,
            primary_field='message',
            primary_objects=group_message_list,
            max_related_objects=max_images_per_message,
            attributes={'image': lambda: fake.image_url()},
            action=action
        )

    if DirectVideoMessage in models_to_update:
        print("________________________________________________________________")
        print("DIRECT VIDEO MESSAGES:")
        load_one_to_many_model(
            model_class=DirectVideoMessage,
            primary_field='message',
            primary_objects=direct_message_list,
            max_related_objects=max_videos_per_message,
            attributes={'video': lambda: fake.image_url()},
            action=action
        )

    if GroupVideoMessage in models_to_update:
        print("________________________________________________________________")
        print("GROUP VIDEO MESSAGES:")
        load_one_to_many_model(
            model_class=GroupVideoMessage,
            primary_field='message',
            primary_objects=group_message_list,
            max_related_objects=max_videos_per_message,
            attributes={'video': lambda: fake.image_url()},
            action=action
        )

def run(*args):
    if len(args) > 0:
        action = args[0]
        models = args[1:] if len(args) > 1 else []
        load_notification(action, *models)
    else:
        load_notification()
