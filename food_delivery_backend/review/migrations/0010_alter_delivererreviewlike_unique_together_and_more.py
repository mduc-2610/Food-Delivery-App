# Generated by Django 5.1 on 2024-09-30 15:10

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("review", "0009_delivererreview_total_likes_and_more"),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name="delivererreviewlike",
            unique_together=set(),
        ),
        migrations.AlterUniqueTogether(
            name="deliveryreviewlike",
            unique_together=set(),
        ),
        migrations.AlterUniqueTogether(
            name="dishreviewlike",
            unique_together=set(),
        ),
        migrations.AlterUniqueTogether(
            name="restaurantreviewlike",
            unique_together=set(),
        ),
    ]
