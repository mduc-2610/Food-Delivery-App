from rest_framework import serializers

from notification.models import DirectRoom, GroupRoom

from notification.serializers import DirectMessageSerializer, GroupMessageSerializer
from utils.serializers import CustomRelatedModelSerializer

class DirectRoomSerializer(CustomRelatedModelSerializer):
    latest_message = DirectMessageSerializer(read_only=True, required=False)
    name = serializers.SerializerMethodField()
    avatar = serializers.SerializerMethodField()

    def get_user_info(self, obj, request):
        user = request.user
        other_user = obj.user2 if user == obj.user1 else obj.user1
        name_type = request.query_params.get('name_type')

        if name_type == 'deliverer' and hasattr(other_user, 'deliverer'):
            return other_user.deliverer, 'basic_info.full_name', 'avatar'
        elif name_type == 'restaurant' and hasattr(other_user, 'restaurant'):
            return other_user.restaurant, 'basic_info.name', 'detail_info.cover_image'
        else:
            return other_user.profile, 'name', 'avatar'

    def get_name(self, obj):
        request = self.context.get('request')
        if request:
            info, name_attr, _ = self.get_user_info(obj, request)
            name = self.get_nested_attribute(info, name_attr)
            return name or "Anonymous"
        return "Anonymous"

    def get_avatar(self, obj):
        request = self.context.get('request')
        if request:
            info, _, avatar_attr = self.get_user_info(obj, request)
            avatar = self.get_nested_attribute(info, avatar_attr)
            if avatar:
                return request.build_absolute_uri(avatar.url)
        return None

    def get_nested_attribute(self, obj, attr_path):
        attrs = attr_path.split('.')
        for attr in attrs:
            obj = getattr(obj, attr, None)
            if obj is None:
                return None
        return obj

    class Meta:
        model = DirectRoom
        fields = '__all__'
        read_only_fields = ('id', 'created_at', 'latest_message', 'name', 'avatar')

    def validate(self, data):
        user1 = data.get('user1')
        user2 = data.get('user2')

        if DirectRoom.objects.filter(user1=user1, user2=user2).exists() \
                or DirectRoom.objects.filter(user1=user2, user2=user1).exists():
            raise serializers.ValidationError("A direct room between these users already exists.")

        return data

        
class GroupRoomSerializer(CustomRelatedModelSerializer):
    latest_message = DirectMessageSerializer()

    class Meta:
        model = GroupRoom
        fields = '__all__'
