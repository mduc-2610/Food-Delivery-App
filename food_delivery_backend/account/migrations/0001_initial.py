# Generated by Django 5.1 on 2024-08-19 03:23

import django.core.validators
import uuid
from django.db import migrations, models


class Migration(migrations.Migration):
    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="User",
            fields=[
                ("password", models.CharField(max_length=128, verbose_name="password")),
                (
                    "id",
                    models.UUIDField(
                        db_index=True,
                        default=uuid.uuid4,
                        editable=False,
                        primary_key=True,
                        serialize=False,
                    ),
                ),
                (
                    "phone_number",
                    models.CharField(
                        help_text="Enter a valid international phone number starting with '+'",
                        max_length=15,
                        unique=True,
                        validators=[
                            django.core.validators.RegexValidator(
                                message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.",
                                regex="\\+(9[976]\\d|8[987530]\\d|6[987]\\d|5[90]\\d|42\\d|3[875]\\d|2[98654321]\\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\\d{1,14}$",
                            )
                        ],
                    ),
                ),
                (
                    "email",
                    models.EmailField(
                        blank=True,
                        max_length=50,
                        null=True,
                        validators=[django.core.validators.EmailValidator()],
                    ),
                ),
                ("is_active", models.BooleanField(default=True)),
                ("is_staff", models.BooleanField(default=False)),
                ("is_superuser", models.BooleanField(default=False)),
                ("date_joined", models.DateTimeField(auto_now_add=True)),
                ("last_login", models.DateTimeField(auto_now=True)),
                ("is_registration_verified", models.BooleanField(default=False)),
            ],
            options={
                "abstract": False,
            },
        ),
        migrations.CreateModel(
            name="Location",
            fields=[
                (
                    "id",
                    models.UUIDField(
                        db_index=True,
                        default=uuid.uuid4,
                        editable=False,
                        primary_key=True,
                        serialize=False,
                    ),
                ),
                ("address", models.CharField(blank=True, max_length=300, null=True)),
                (
                    "latitude",
                    models.DecimalField(
                        blank=True, decimal_places=6, max_digits=9, null=True
                    ),
                ),
                (
                    "longitude",
                    models.DecimalField(
                        blank=True, decimal_places=6, max_digits=9, null=True
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="OTP",
            fields=[
                (
                    "id",
                    models.UUIDField(
                        db_index=True,
                        default=uuid.uuid4,
                        editable=False,
                        primary_key=True,
                        serialize=False,
                    ),
                ),
                ("code", models.CharField(max_length=4)),
                ("expired_at", models.DateTimeField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name="Profile",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "avatar",
                    models.ImageField(blank=True, null=True, upload_to="avatar/"),
                ),
                ("name", models.CharField(blank=True, max_length=155, null=True)),
                (
                    "gender",
                    models.CharField(
                        blank=True,
                        choices=[("MALE", "male"), ("FEMALE", "female")],
                        max_length=7,
                        null=True,
                    ),
                ),
                ("date_of_birth", models.DateTimeField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name="SecuritySetting",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("face_id", models.BooleanField(default=False)),
                ("touch_id", models.BooleanField(default=False)),
                ("pin_security", models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name="Setting",
            fields=[
                (
                    "id",
                    models.UUIDField(
                        db_index=True,
                        default=uuid.uuid4,
                        editable=False,
                        primary_key=True,
                        serialize=False,
                    ),
                ),
                ("notification", models.BooleanField(default=True)),
                ("dark_mode", models.BooleanField(default=False)),
                ("sound", models.BooleanField(default=False)),
                ("automatically_updated", models.BooleanField(default=False)),
                (
                    "language",
                    models.CharField(
                        choices=[("ENGLISH", "English"), ("VIETNAMESE", "Vietnamese")],
                        default="ENGLISH",
                        max_length=30,
                    ),
                ),
            ],
        ),
    ]
