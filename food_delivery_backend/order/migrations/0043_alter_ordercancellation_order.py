# Generated by Django 5.1 on 2024-09-08 16:36

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0042_ordercancellation_is_accepted"),
    ]

    operations = [
        migrations.AlterField(
            model_name="ordercancellation",
            name="order",
            field=models.OneToOneField(
                on_delete=django.db.models.deletion.CASCADE,
                related_name="cancellation",
                to="order.order",
            ),
        ),
    ]
