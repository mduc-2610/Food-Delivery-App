import random
from faker import Faker

from django.utils import timezone

from account.models import User
from notification.models import (
    UserNotification, Notification, 
    Message, ImageMessage, AudioMessage, LocationMessage
)

from utils.function import load_intermediate_model

fake = Faker()

def load_notification(
        max_notifications=50, 
        max_messages=200,
        max_user_notifications=30
    ):
    model_list = [
        UserNotification, Notification, 
        Message, ImageMessage, AudioMessage, LocationMessage
    ]
    
    for model in model_list:
        model.objects.all().delete()

    user_list = User.objects.all()
    
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

    print("________________________________________________________________")
    print("MESSAGES:")
    message_list = []
    user_list = list(user_list)
    for _ in range(max_messages):
        sender, receiver = random.sample(user_list, 2)
        while Message.objects.filter(sender=sender, receiver=receiver).exists():
            sender, receiver = random.sample(user_list, 2)
        message_data = {
            "sender": sender,
            "receiver": receiver,
            "message_type": fake.random_element(elements=('text', 'image', 'audio', 'location')),
            "content": fake.text(max_nb_chars=200) if fake.random_element(elements=('text', 'image', 'audio', 'location')) == 'text' else '',
            "timestamp": timezone.now(),
            "read_status": fake.boolean()
        }
        message, _ = Message.objects.get_or_create(**message_data)
        message_list.append(message)
        print(f"\tSuccessfully created Message: {message}")

    print("________________________________________________________________")
    print("IMAGE MESSAGES:")
    for message in message_list:
        if message.message_type == 'image':
            image_message_data = {
                "message": message,
                "image": fake.image_url()
            }
            image_message = ImageMessage.objects.create(**image_message_data)
            print(f"\tSuccessfully created Image Message: {image_message}")

    print("________________________________________________________________")
    print("AUDIO MESSAGES:")
    for message in message_list:
        if message.message_type == 'audio':
            audio_message_data = {
                "message": message,
                "audio": fake.file_path(extension='mp3')
            }
            audio_message = AudioMessage.objects.create(**audio_message_data)
            print(f"\tSuccessfully created Audio Message: {audio_message}")

    print("________________________________________________________________")
    print("LOCATION MESSAGES:")
    for message in message_list:
        if message.message_type == 'location':
            location_message_data = {
                "message": message,
                "latitude": fake.latitude(),
                "longitude": fake.longitude()
            }
            location_message = LocationMessage.objects.create(**location_message_data)
            print(f"\tSuccessfully created Location Message: {location_message}")
    
    return notification_list, message_list
