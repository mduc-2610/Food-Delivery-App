# Generated by Django 5.1 on 2024-09-13 15:49

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0050_order_is_reviewed"),
    ]

    operations = [
        migrations.AddField(
            model_name="order",
            name="is_restaurant_reviewed",
            field=models.BooleanField(blank=True, default=False, null=True),
        ),
    ]
