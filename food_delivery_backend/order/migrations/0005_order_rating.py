# Generated by Django 5.1 on 2024-08-19 09:55

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0004_alter_restaurantcartdish_unique_together"),
    ]

    operations = [
        migrations.AddField(
            model_name="order",
            name="rating",
            field=models.PositiveSmallIntegerField(default=1),
        ),
    ]
