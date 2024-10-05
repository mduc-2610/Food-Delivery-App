# promotion/serializers.py
from rest_framework import serializers
from order.models import (
    RestaurantPromotion,
    # ActivityPromotion,
)

class RestaurantPromotionSerializer(serializers.ModelSerializer):
    promo_type = serializers.CharField(source='get_promo_type_display')
    is_available = serializers.SerializerMethodField()

    def get_is_available(self, obj):
        return obj.is_available(request=self.context.get('request'))
    
    class Meta:
        model = RestaurantPromotion
        fields = [
            'id', 
            'name',
            'code',
            'promo_type',
            'restaurant',
            'discount_percentage',
            'discount_amount',
            'start_date',
            'end_date',
            'applicable_price',
            'description',
            'terms_and_conditions',
            'is_disabled',
            'is_available'
        ]
        read_only_fields = ['id', 'is_available', 'restaurant']



class CreateRestaurantPromotionSerializer(serializers.ModelSerializer):
    class Meta:
        model = RestaurantPromotion
        fields = [
            'id', 
            'name',
            'code',
            'restaurant',
            'promo_type',
            'discount_percentage',
            'discount_amount',
            'start_date',
            'end_date',
            'applicable_price',
            'description',
            'terms_and_conditions',
            'is_disabled',
        ]
        read_only_fields = ['id', 'is_available',]
    
    def to_representation(self, instance):
        return RestaurantPromotionSerializer(instance, context=self.context).data

# class ActivityPromotionSerializer(serializers.ModelSerializer):
#     promotion = PromotionSerializer()

#     class Meta:
#         model = ActivityPromotion
#         fields = ['promotion', 'activity_type']
