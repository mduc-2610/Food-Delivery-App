from rest_framework import serializers
from deliverer.models import Address

class AddressSerializer(serializers.ModelSerializer):
    deliverer = serializers.PrimaryKeyRelatedField(queryset=Address.objects.all())
    class Meta:
        model = Address
        fields = ['id', 'deliverer', 'city', 'district', 'ward', 'detail_address']
