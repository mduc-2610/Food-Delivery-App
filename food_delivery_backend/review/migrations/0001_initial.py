# Generated by Django 3.2.7 on 2024-07-27 15:36

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import uuid


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('order', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('deliverer', '0001_initial'),
        ('restaurant', '0001_initial'),
        ('food', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='DelivererReview',
            fields=[
                ('id', models.UUIDField(db_index=True, default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('rating', models.PositiveSmallIntegerField(blank=True, null=True)),
                ('title', models.CharField(blank=True, max_length=255, null=True)),
                ('comment', models.TextField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('deliverer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='user_reviews', to='deliverer.deliverer')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='deliverer_reviews', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'unique_together': {('user', 'deliverer')},
            },
        ),
        migrations.CreateModel(
            name='DeliveryReview',
            fields=[
                ('id', models.UUIDField(db_index=True, default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('rating', models.PositiveSmallIntegerField(blank=True, null=True)),
                ('title', models.CharField(blank=True, max_length=255, null=True)),
                ('comment', models.TextField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('delivery', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='delivery_reviews', to='order.delivery')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='delivery_reviews', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'unique_together': {('user', 'delivery')},
            },
        ),
        migrations.CreateModel(
            name='DishReview',
            fields=[
                ('id', models.UUIDField(db_index=True, default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('rating', models.PositiveSmallIntegerField(blank=True, null=True)),
                ('title', models.CharField(blank=True, max_length=255, null=True)),
                ('comment', models.TextField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('dish', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='user_reviews', to='food.dish')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='dish_reviews', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'unique_together': {('user', 'dish')},
            },
        ),
        migrations.CreateModel(
            name='RestaurantReview',
            fields=[
                ('id', models.UUIDField(db_index=True, default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('rating', models.PositiveSmallIntegerField(blank=True, null=True)),
                ('title', models.CharField(blank=True, max_length=255, null=True)),
                ('comment', models.TextField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('restaurant', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='user_reviews', to='restaurant.restaurant')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='restaurant_reviews', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'unique_together': {('user', 'restaurant')},
            },
        ),
        migrations.CreateModel(
            name='RestaurantReviewLike',
            fields=[
                ('id', models.UUIDField(db_index=True, default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('review', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='restaurant_review_likes', to='review.restaurantreview')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='restaurant_review_likes', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-created_at',),
                'abstract': False,
                'unique_together': {('user', 'review')},
            },
        ),
        migrations.CreateModel(
            name='DishReviewLike',
            fields=[
                ('id', models.UUIDField(db_index=True, default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('review', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='dish_review_likes', to='review.dishreview')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='dish_review_likes', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-created_at',),
                'abstract': False,
                'unique_together': {('user', 'review')},
            },
        ),
        migrations.CreateModel(
            name='DeliveryReviewLike',
            fields=[
                ('id', models.UUIDField(db_index=True, default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('review', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='delivery_review_likes', to='review.deliveryreview')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='delivery_review_likes', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-created_at',),
                'abstract': False,
                'unique_together': {('user', 'review')},
            },
        ),
        migrations.CreateModel(
            name='DelivererReviewLike',
            fields=[
                ('id', models.UUIDField(db_index=True, default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('review', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='deliverer_review_likes', to='review.delivererreview')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='deliverer_review_likes', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-created_at',),
                'abstract': False,
                'unique_together': {('user', 'review')},
            },
        ),
    ]
