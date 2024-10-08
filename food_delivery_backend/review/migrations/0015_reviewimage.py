# Generated by Django 5.1 on 2024-10-10 07:47

import django.db.models.deletion
import review.models.review_image
import uuid
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("contenttypes", "0002_remove_content_type_name"),
        ("review", "0014_reviewreply_remove_delivererreview_reply_and_more"),
    ]

    operations = [
        migrations.CreateModel(
            name="ReviewImage",
            fields=[
                (
                    "id",
                    models.UUIDField(
                        default=uuid.uuid4,
                        editable=False,
                        primary_key=True,
                        serialize=False,
                    ),
                ),
                (
                    "image",
                    models.ImageField(
                        max_length=255, upload_to=review.models.review_image.upload_path
                    ),
                ),
                ("uploaded_at", models.DateTimeField(auto_now_add=True)),
                ("object_id", models.UUIDField()),
                (
                    "content_type",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="contenttypes.contenttype",
                    ),
                ),
            ],
        ),
    ]
