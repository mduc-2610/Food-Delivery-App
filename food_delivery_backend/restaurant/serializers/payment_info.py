from rest_framework import serializers
from restaurant.models import PaymentInfo

class BasicPaymentInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentInfo
        fields = '__all__'
        read_only_fields = ['id']


class PaymentInfoSerializer(BasicPaymentInfoSerializer):
    pass
    
class UpdatePaymentInfoSerializer(BasicPaymentInfoSerializer):
    class Meta(BasicPaymentInfoSerializer.Meta):
        read_only_fields = ['id', 'restaurant']