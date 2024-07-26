from rest_framework import viewsets

from restaurant.models import Restaurant

from restaurant.serializers import RestaurantSerializer

class RestaurantViewSet(viewsets.ModelViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer

    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "list":
            context['many'] = True
        return context