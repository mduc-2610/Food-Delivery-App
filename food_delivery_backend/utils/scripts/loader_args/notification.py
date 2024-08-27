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

@transaction.atomic
def load_notification(
        max_notifications=50, 
        max_user_notifications=30,
        max_group_users=20,
        max_direct_rooms=80, 
        max_group_rooms=50,
        max_direct_messages_per_room=30,
        max_group_messages_per_room=20,
        max_videos_per_message=2,
        max_images_per_message=3,
        models_to_update=None
    ):
    all_objects = {model: model.objects.all() for model in MODEL_MAP.values()}

    if models_to_update is None or models_to_update:
        models_to_update_classes = [MODEL_MAP[m] for m in models_to_update if m in MODEL_MAP] if models_to_update else MODEL_MAP.values()

        if Notification in models_to_update_classes:
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

        if UserNotification in models_to_update_classes:
            print("________________________________________________________________")
            print("USER NOTIFICATIONS:")
            load_intermediate_model(
                model_class=UserNotification,
                primary_field='user',
                related_field='notification',
                primary_objects=all_objects[User],
                related_objects=all_objects[Notification],
                max_items=max_user_notifications
            )

        if DirectRoom in models_to_update_classes:
            print("________________________________________________________________")
            print("DIRECT ROOMS:")
            direct_room_list = load_intermediate_model(
                model_class=DirectRoom,
                primary_field='user1',
                related_field='user2',
                primary_objects=all_objects[User],
                related_objects=all_objects[User],
                max_items=max_direct_rooms,
                attributes={}
            )
        else:
            direct_room_list = []

        if GroupRoom in models_to_update_classes:
            print("________________________________________________________________")
            print("GROUP ROOMS:")
            group_room_list = [
                GroupRoom.objects.create(
                    name=fake.sentence(nb_words=4)
                ) for _ in range(max_group_rooms)
            ]
            for group_room in group_room_list:
                tmp_users = all_objects[User].copy()
                group_room.members.add(*[tmp_users.pop(random.randint(0, len(tmp_users) - 1)) for _ in range(random.randint(3, max_group_users))])
            print(f"\tSuccessfully created {len(group_room_list)} Group Rooms.")
        else:
            group_room_list = []

        if DirectMessage in models_to_update_classes:
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

        if GroupMessage in models_to_update_classes:
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

        if DirectImageMessage in models_to_update_classes:
            print("________________________________________________________________")
            print("DIRECT IMAGE MESSAGES:")
            load_one_to_many_model(
                model_class=DirectImageMessage,
                primary_field='message',
                primary_objects=direct_message_list,
                max_related_objects=max_images_per_message,
                attributes={'image': lambda: fake.image_url()}
            )

        if GroupImageMessage in models_to_update_classes:
            print("________________________________________________________________")
            print("GROUP IMAGE MESSAGES:")
            load_one_to_many_model(
                model_class=GroupImageMessage,
                primary_field='message',
                primary_objects=group_message_list,
                max_related_objects=max_images_per_message,
                attributes={'image': lambda: fake.image_url()}
            )

        if DirectVideoMessage in models_to_update_classes:
            print("________________________________________________________________")
            print("DIRECT VIDEO MESSAGES:")
            load_one_to_many_model(
                model_class=DirectVideoMessage,
                primary_field='message',
                primary_objects=direct_message_list,
                max_related_objects=max_videos_per_message,
                attributes={'video': lambda: fake.image_url()}
            )

        if GroupVideoMessage in models_to_update_classes:
            print("________________________________________________________________")
            print("GROUP VIDEO MESSAGES:")
            load_one_to_many_model(
                model_class=GroupVideoMessage,
                primary_field='message',
                primary_objects=group_message_list,
                max_related_objects=max_videos_per_message,
                attributes={'video': lambda: fake.image_url()}
            )

def delete_models(models_to_delete):
    for model in models_to_delete:
        model.objects.all().delete()

def run(*args):
    action = args[0] if args else None

    if action == 'delete':
        models_to_delete = args[1:] if len(args) > 1 else MODEL_MAP.keys()
        delete_models([MODEL_MAP[m] for m in models_to_delete if m in MODEL_MAP])
        models_to_update = args[1:] if len(args) > 1 else None
    elif action == 'update':
        models_to_update = args[1:] if len(args) > 1 else None
    else:
        models_to_update = None

    if models_to_update is not None or action is None:
        load_notification(models_to_update=models_to_update)
    elif action not in ['delete', 'update']:
        print("Invalid action. Use 'delete' or 'update'.")
