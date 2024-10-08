# Generated by Django 5.1 on 2024-09-01 07:08

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0029_alter_delivery_order_deliveryrequest"),
    ]

    operations = [
        migrations.AlterField(
            model_name="delivery",
            name="order",
            field=models.OneToOneField(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="deliverers",
                to="order.order",
            ),
        ),
        migrations.AlterField(
            model_name="deliveryrequest",
            name="delivery",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE,
                related_name="requested_deliverers",
                to="order.delivery",
            ),
        ),
    ]
