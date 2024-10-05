# Generated by Django 5.1 on 2024-10-06 02:19

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0065_orderrestaurantpromotion_and_more"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AlterField(
            model_name="userrestaurantpromotion",
            name="promotion",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE,
                related_name="user_used",
                to="order.restaurantpromotion",
            ),
        ),
        migrations.AlterField(
            model_name="userrestaurantpromotion",
            name="user",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE,
                related_name="user_used",
                to=settings.AUTH_USER_MODEL,
            ),
        ),
    ]
