# Generated by Django 5.1 on 2024-09-13 16:28

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0051_order_is_restaurant_reviewed"),
        ("review", "0005_alter_delivererreview_options_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="delivererreview",
            name="order",
            field=models.OneToOneField(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="deliverer_reviews",
                to="order.order",
            ),
        ),
        migrations.AlterField(
            model_name="deliveryreview",
            name="order",
            field=models.OneToOneField(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="delivery_reviews",
                to="order.order",
            ),
        ),
        migrations.AlterField(
            model_name="dishreview",
            name="order",
            field=models.OneToOneField(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="dish_reviews",
                to="order.order",
            ),
        ),
        migrations.AlterField(
            model_name="restaurantreview",
            name="order",
            field=models.OneToOneField(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="restaurant_reviews",
                to="order.order",
            ),
        ),
    ]
