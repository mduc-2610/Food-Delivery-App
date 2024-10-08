# Generated by Django 5.1 on 2024-10-05 09:16

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0060_remove_order_discount"),
    ]

    operations = [
        migrations.AlterField(
            model_name="order",
            name="payment_method",
            field=models.CharField(
                choices=[("CASH", "Cash"), ("CARD", "Card"), ("PAYPAL", "Paypal")],
                default="CASH",
                max_length=10,
            ),
        ),
    ]
