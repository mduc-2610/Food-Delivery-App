# Generated by Django 5.1 on 2024-09-13 09:28

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0049_rename_is_food_reviewed_order_is_dish_reviewed"),
    ]

    operations = [
        migrations.AddField(
            model_name="order",
            name="is_reviewed",
            field=models.BooleanField(blank=True, default=False, null=True),
        ),
    ]
