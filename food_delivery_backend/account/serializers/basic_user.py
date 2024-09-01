from rest_framework import serializers
from django.conf import settings
from django.utils.html import escape

from account.models import User

class BasicUserSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    avatar = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = ['id', 'name', 'phone_number', 'avatar']
        depth = 2

    def get_name(self, obj):
        return obj.profile.name if hasattr(obj, 'profile') else None
    
    def get_avatar(self, obj):
        request = self.context.get('request')
        if request and hasattr(obj, 'profile') and obj.profile.avatar:
            avatar_url = obj.profile.avatar.url
            return request.build_absolute_uri(avatar_url)
        return None
