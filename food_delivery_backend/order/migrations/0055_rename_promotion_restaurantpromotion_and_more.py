# Generated by Django 5.1 on 2024-10-05 07:43

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0054_remove_orderpromotion_order_and_more"),
    ]

    operations = [
        migrations.RenameModel(
            old_name="Promotion",
            new_name="RestaurantPromotion",
        ),
        migrations.RemoveField(
            model_name="order",
            name="promotion",
        ),
        migrations.AddField(
            model_name="order",
            name="restaurant_promotion",
            field=models.ManyToManyField(
                blank=True, related_name="orders", to="order.restaurantpromotion"
            ),
        ),
    ]
