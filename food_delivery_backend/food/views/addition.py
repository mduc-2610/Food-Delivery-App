# food/views.py
from rest_framework import viewsets
from food.models import DishAdditionalOption
from food.serializers import DishAdditionalOptionSerializer

class DishAdditionalOptionViewSet(viewsets.ModelViewSet):
    queryset = DishAdditionalOption.objects.all()
    serializer_class = DishAdditionalOptionSerializer
