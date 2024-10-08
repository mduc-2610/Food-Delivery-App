# Generated by Django 5.1 on 2024-10-05 08:48

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("account", "0008_remove_user_promotions"),
        ("order", "0058_userrestaurantpromotion"),
    ]

    operations = [
        migrations.AddField(
            model_name="user",
            name="user_restaurant_promotions",
            field=models.ManyToManyField(
                related_name="owned_by_users",
                through="order.UserRestaurantPromotion",
                to="order.restaurantpromotion",
            ),
        ),
    ]
