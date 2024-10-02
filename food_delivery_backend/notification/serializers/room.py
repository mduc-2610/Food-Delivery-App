from rest_framework import serializers

from notification.models import DirectRoom, GroupRoom

from notification.serializers import DirectMessageSerializer, GroupMessageSerializer
from utils.serializers import CustomRelatedModelSerializer

class DirectRoomSerializer(CustomRelatedModelSerializer):
    latest_message = DirectMessageSerializer(read_only=True, required=False)
    name = serializers.SerializerMethodField()

    def get_name(self, obj):
        request = self.context.get('request')
        if request:
            user = request.user
            user1 = obj.user1
            user2 = obj.user2
            
            params = request.query_params
            name_type = params.get('name_type', None)
            print(name_type, pretty=True)
            if name_type == 'deliverer':
                if user == user1 and hasattr(user2, 'deliverer'):
                    return user2.deliverer.basic_info.full_name
                elif user == user2 and hasattr(user1, 'deliverer'):
                    return user1.deliverer.basic_info.full_name
            
            elif name_type == 'restaurant':
                if user == user1 and hasattr(user2, 'restaurant') and user2.restaurant.basic_info.name:
                    return user2.restaurant.basic_info.name
                elif user == user2 and hasattr(user1, 'restaurant') and user1.restaurant.basic_info.name:
                    return user1.restaurant.basic_info.name
            
            if user == user1:
                return user2.profile.name
            else:
                return user1.profile.name
        return "Anonymous"

    class Meta:
        model = DirectRoom
        fields = '__all__'
        read_only_fields = ('id', 'created_at', 'latest_message', 'name')

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
