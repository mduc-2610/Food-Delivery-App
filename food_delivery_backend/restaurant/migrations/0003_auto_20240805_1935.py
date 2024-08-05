# Generated by Django 3.2.7 on 2024-08-05 12:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('restaurant', '0002_auto_20240804_2156'),
    ]

    operations = [
        migrations.AddField(
            model_name='restaurant',
            name='rating',
            field=models.DecimalField(decimal_places=1, default=0, max_digits=3),
        ),
        migrations.AddField(
            model_name='restaurant',
            name='total_reviews',
            field=models.IntegerField(default=0),
        ),
    ]
