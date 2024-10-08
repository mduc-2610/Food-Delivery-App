# Generated by Django 5.1 on 2024-10-05 10:46

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0061_alter_order_payment_method"),
        ("restaurant", "0015_remove_restaurant_promotions"),
    ]

    operations = [
        migrations.AlterField(
            model_name="restaurantpromotion",
            name="restaurant",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="promotions",
                to="restaurant.restaurant",
            ),
        ),
    ]
