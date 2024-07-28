from rest_framework import (
    response, viewsets, status
)
from rest_framework.decorators import action

from food.models import Dish

from account.serializers import UserSerializer
from food.serializers import DishSerializer, DetailDishSerializer
from review.serializers import DishReviewSerializer

class DishViewSet(viewsets.ModelViewSet):
    queryset = Dish.objects.all()
    serializer_class = DishSerializer
    action_serializer_classes = {
        'retrieve': DetailDishSerializer,
        'liked_by_users': UserSerializer,
        'rated_by_users': UserSerializer,
    }

    def get_serializer_class(self):
        return self.action_serializer_classes.get(
            self.action, super().get_serializer_class())
    
    def get_object(self):
        pk = self.kwargs.get('pk', None)
        many_related_queryset = {
            "liked_by_users": lambda instance: instance.liked_by_users.all(),
            "rated_by_users": lambda instance: instance.rated_by_users.all()
        }
        if self.action in many_related_queryset.keys():
            try:
                user = Dish.objects.get(pk=pk)
            except Dish.DoesNotExist:
                return response.Response(
                    {
                        "message": "Dish not found."
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
            return many_related_queryset.get(self.action)(user)
        return super().get_object()
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "liked_by_users" or self.action == "rated_by_users":
            context.update({"many": True})
        return context

    def paginate_and_response(self, request):
        queryset = self.get_object()
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        
        serializer = self.get_serializer(queryset, many=True)
        return response.Response(serializer.data, status=status.HTTP_200_OK)

    @action(detail=True, methods=["GET"], url_path="liked-by-users")
    def liked_by_users(self, request, *args, **kwargs):
        return self.paginate_and_response(request)

    @action(detail=True, methods=["GET"], url_path="rated-by-users")
    def rated_by_users(self, request, *args, **kwargs):
        return self.paginate_and_response(request)