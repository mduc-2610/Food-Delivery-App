# Generated by Django 5.1 on 2024-08-23 02:19

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("food", "0007_dishoptionitem"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="dishsizeoption",
            name="dish",
        ),
        migrations.DeleteModel(
            name="DishAdditionalOption",
        ),
        migrations.DeleteModel(
            name="DishSizeOption",
        ),
    ]
