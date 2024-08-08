# Generated by Django 5.1 on 2024-08-09 03:31

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("notification", "0007_rename_timestamp_directmessage_created_at_and_more"),
    ]

    operations = [
        migrations.AlterModelOptions(
            name="directimagemessage",
            options={
                "verbose_name": "Direct Image Message",
                "verbose_name_plural": "Direct Image Messages",
            },
        ),
        migrations.AlterModelOptions(
            name="directvideomessage",
            options={
                "verbose_name": "Direct Video Message",
                "verbose_name_plural": "Direct Video Messages",
            },
        ),
        migrations.AlterModelOptions(
            name="groupimagemessage",
            options={
                "verbose_name": "Group Image Message",
                "verbose_name_plural": "Group Image Messages",
            },
        ),
        migrations.AlterModelOptions(
            name="groupvideomessage",
            options={
                "verbose_name": "Group Video Message",
                "verbose_name_plural": "Group Video Messages",
            },
        ),
        migrations.RemoveField(
            model_name="directimagemessage",
            name="direct_message",
        ),
        migrations.RemoveField(
            model_name="directvideomessage",
            name="direct_message",
        ),
        migrations.RemoveField(
            model_name="groupimagemessage",
            name="group_message",
        ),
        migrations.RemoveField(
            model_name="groupvideomessage",
            name="group_message",
        ),
        migrations.AddField(
            model_name="directimagemessage",
            name="message",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                to="notification.directmessage",
            ),
        ),
        migrations.AddField(
            model_name="directvideomessage",
            name="message",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                to="notification.directmessage",
            ),
        ),
        migrations.AddField(
            model_name="groupimagemessage",
            name="message",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                to="notification.groupmessage",
            ),
        ),
        migrations.AddField(
            model_name="groupvideomessage",
            name="message",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                to="notification.groupmessage",
            ),
        ),
    ]
