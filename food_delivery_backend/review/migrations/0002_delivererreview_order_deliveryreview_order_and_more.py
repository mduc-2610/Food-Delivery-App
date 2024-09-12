# Generated by Django 5.1 on 2024-09-13 06:03

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0048_order_is_deliverer_reviewed_order_is_food_reviewed_and_more"),
        ("review", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="delivererreview",
            name="order",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="deliverer_reviews",
                to="order.order",
            ),
        ),
        migrations.AddField(
            model_name="deliveryreview",
            name="order",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="delivery_reviews",
                to="order.order",
            ),
        ),
        migrations.AddField(
            model_name="dishreview",
            name="order",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="dish_reviews",
                to="order.order",
            ),
        ),
        migrations.AddField(
            model_name="restaurantreview",
            name="order",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="restaurant_reviews",
                to="order.order",
            ),
        ),
    ]
