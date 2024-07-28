from rest_framework import serializers

from account.models import User

class UserAbbrSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = ['id', 'name', 'phone_number']
        depth = 2

    def get_name(self, obj):
        return obj.profile.name
    