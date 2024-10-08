# Generated by Django 5.1 on 2024-08-27 10:39

import account.models.profile
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("account", "0004_location_name"),
    ]

    operations = [
        migrations.AlterField(
            model_name="profile",
            name="avatar",
            field=models.ImageField(
                blank=True,
                null=True,
                upload_to=account.models.profile.user_avatar_upload_path,
            ),
        ),
    ]
