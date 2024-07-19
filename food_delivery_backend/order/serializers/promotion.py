# promotion/serializers.py
from rest_framework import serializers
from order.models import Promotion, ActivityPromotion

class PromotionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Promotion
        fields = [
            'id', 'code', 'description', 'promo_type', 
            'discount_percentage', 'discount_amount', 
            'start_date', 'end_date', 'applicable_scope', 
            'terms_and_conditions', 'active', 'is_active'
        ]

class ActivityPromotionSerializer(serializers.ModelSerializer):
    promotion = PromotionSerializer()

    class Meta:
        model = ActivityPromotion
        fields = ['promotion', 'activity_type']
