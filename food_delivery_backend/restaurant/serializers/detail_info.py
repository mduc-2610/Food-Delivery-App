# detailinformation/serializers.py

from rest_framework import serializers
from django.core.exceptions import ValidationError
from restaurant.models import DetailInfo, validate_operating_hours

from rest_framework import serializers
from restaurant.models import DetailInfo
import json

class OperatingHoursField(serializers.JSONField):
    def to_internal_value(self, data):
        if isinstance(data, str):
            try:
                data = json.loads(data)
            except json.JSONDecodeError:
                raise serializers.ValidationError("Invalid JSON format for operating hours")
        return super().to_internal_value(data)

class BaseDetailInfoSerializer(serializers.ModelSerializer):
    operating_hours = OperatingHoursField()

    class Meta:
        model = DetailInfo
        fields = [
            'id',
            'restaurant',
            'keywords',
            'description',
            'avatar_image',
            'cover_image',
            'facade_image',
            'restaurant_type',
            'cuisine',
            'specialty_dishes',
            'serving_times',
            'target_audience',
            'purpose',
            'operating_hours',
        ]
        read_only_fields = ['id']

    def validate_operating_hours(self, value):
        try:
            validate_operating_hours(json.dumps(value))
        except ValidationError as e:
            raise serializers.ValidationError(str(e))
        return value

    def create(self, validated_data):
        return DetailInfo.objects.create(**validated_data)

    def update(self, instance, validated_data):
        print(validated_data, pretty=True)
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()
        return instance

class DetailInfoSerializer(BaseDetailInfoSerializer):
    pass

class UpdateDetailInfoSerializer(BaseDetailInfoSerializer):
    class Meta(BaseDetailInfoSerializer.Meta):
        read_only_fields = ['id', 'restaurant']