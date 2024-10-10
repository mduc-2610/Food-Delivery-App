from rest_framework import serializers

from restaurant.models import Restaurant

class BasicRestaurantSerializer(serializers.ModelSerializer):
    distance_from_user = serializers.SerializerMethodField()

    def get_distance_from_user(self, obj):
        request = self.context.get('request')
        if request and hasattr(request, 'user') and hasattr(request.user, 'locations'):
            user_location = request.user.locations.filter(is_selected=True).first()
            if user_location:
                return obj.basic_info.get_distance_from_user(user_location)
        return None
    
    class Meta:
        model = Restaurant
        fields = [
            'id', 'basic_info', 'detail_info', 'distance_from_user', 'rating', 'total_reviews', 'avg_price'
        ]
        depth = 1