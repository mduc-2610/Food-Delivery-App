import random
from faker import Faker
from datetime import datetime, timedelta

from django.utils import timezone
from django.db import transaction
from django.contrib.auth.hashers import make_password

from account.models import (
    User, OTP,
    Profile, Location, 
    Setting, SecuritySetting 
)
from deliverer.models import Deliverer

def run(mode=None, *args):
    # print("________________________________________________________________")
    # print(type(args))
    from django.apps import apps

    # Get all models
    all_models = apps.get_models()

    # Print model names
    for model in all_models:
        print(model.__name__, len(model.objects.all()))

    # users = Profile.objects.all()
    # for user in users:
    #     user.avatar = None
    #     user.save(update_fields=['avatar'])

    # deliverers = Deliverer.objects.all()
    # for deliverer in deliverers:
    #     deliverer.avatar = None
    #     deliverer.save(update_fields=['avatar']) 
    # print(User.objects.all()[0].profile.avatar == '')