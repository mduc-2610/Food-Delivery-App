import pytz
from datetime import datetime, timedelta
from datetime import timedelta

from django.utils import timezone
from django.db.models import Count, Sum, Q

from rest_framework import (
    response,
    viewsets,
    status,
)
from rest_framework.decorators import action

from restaurant.models import (
    Restaurant,
    RestaurantCategory,
    RestaurantLike,
)
from order.models import Order

from restaurant.serializers import (
    RestaurantSerializer, 
    CreateRestaurantSerializer,
    DetailRestaurantSerializer, 
    UpdateRestaurantSerializer,
    RestaurantCategorySerializer,
    RestaurantLikeSerializer,
)
from account.serializers import BasicUserSerializer
from food.serializers import (
    DishSerializer,
    DishCategorySerializer,
)
from order.serializers import (
    PromotionSerializer,
    RestaurantPromotionSerializer,
    DeliverySerializer,    
)
from restaurant.serializers import CreateUpdateRestaurantCategorySerializer
from review.serializers import RestaurantReviewSerializer
from review.mixins import ReviewFilterMixin

from order.mixins import DeliveryFilterMixin
from utils.views import ManyRelatedViewSet
from utils.pagination import CustomPagination
from utils.mixins import (
    DefaultGenericMixin,
    ForeignKeyFilterMixin,
)


class RestaurantViewSet(DefaultGenericMixin, ReviewFilterMixin, DeliveryFilterMixin, ManyRelatedViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer
    pagination_class = CustomPagination
    many_related_serializer_class = {
        'retrieve': DetailRestaurantSerializer,
        'create': CreateRestaurantSerializer,
        'update': UpdateRestaurantSerializer,
        'promotions': PromotionSerializer,
        'reviewed_by_users': BasicUserSerializer,
        'dishes': DishSerializer,
        'restaurant_reviews': RestaurantReviewSerializer,
        'owned_promotions': RestaurantPromotionSerializer,
        'categories': DishCategorySerializer,
        'restaurant_categories': RestaurantCategorySerializer,
        'deliveries': DeliverySerializer,
    }
    many_related = {
        'dishes': {
            'pagination': False,
        }
    }
    
    def get_queryset(self):
        queryset = super().get_queryset()
        params = self.request.query_params
        name = params.get('name')
        category = params.get('category')
        dish_category = params.get('dish_category')

        filter_kwargs = Q()
        if name:
            filter_kwargs &= Q(basic_info__name__icontains=name)
        if category:
            filter_kwargs &= Q(categories__name__icontains=category.lower())
        if dish_category:
            filter_kwargs &= Q(dishes__category__name__icontains=dish_category.lower())

        return queryset.filter(filter_kwargs).distinct()
    
    def get_object(self):
        if self.action == 'restaurant_reviews':
            return ReviewFilterMixin.get_object(self)
        elif self.action == 'deliveries':
            return DeliveryFilterMixin.get_object(self)
        elif self.action == "restaurant_categories":
            return self.filter_restaurant_categories()
        return super().get_object()
    
    def filter_restaurant_categories(self):
        queryset = super().get_object()
        is_disabled = self.request.query_params.get('is_disabled', None)
        if is_disabled:
            return queryset.filter(is_disabled=is_disabled)
        return queryset
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "list":
            context.update({'detail': False})
        return context
    
    @action(detail=True, methods=['get'])
    def stats(self, request, pk=None):
        """
            GET /restaurants/{id}/stats/?time_range=daily
            GET /restaurants/{id}/stats/?time_range=daily&day=2024-04-25
            GET /restaurants/{id}/stats/?time_range=monthly
            GET /restaurants/{id}/stats/?time_range=monthly&month=2024-04
            GET /restaurants/{id}/stats/?time_range=yearly
            GET /restaurants/{id}/stats/?time_range=yearly&year=2023
        """
        try:
            restaurant = self.get_object()
            time_range = request.query_params.get('time_range', 'daily').lower()
            day = request.query_params.get('day')
            month = request.query_params.get('month')
            year = request.query_params.get('year')
            min_price = request.query_params.get('min_price')
            max_price = request.query_params.get('max_price')
            min_orders = request.query_params.get('min_orders')
            max_orders = request.query_params.get('max_orders')

            orders = Order.objects.filter(cart__restaurant=restaurant, status="COMPLETED")

            tz_name = restaurant.detail_info.operating_hours.get('timezone', 'UTC')
            try:
                tz = pytz.timezone(tz_name)
            except pytz.UnknownTimeZoneError:
                tz = pytz.UTC

            now = timezone.now().astimezone(tz)

            if time_range == 'daily':
                if day:
                    try:
                        selected_day = datetime.strptime(day, "%Y-%m-%d").date()
                    except ValueError:
                        return response.Response({"error": "Invalid day format. Use YYYY-MM-DD."}, status=status.HTTP_400_BAD_REQUEST)
                else:
                    selected_day = now.date()
                start_date = datetime.combine(selected_day, datetime.min.time()).replace(tzinfo=tz)
                end_date = start_date + timedelta(days=1)

            elif time_range == 'monthly':
                if month:
                    try:
                        selected_month = datetime.strptime(month, "%Y-%m").date()
                    except ValueError:
                        return response.Response({"error": "Invalid month format. Use YYYY-MM."}, status=status.HTTP_400_BAD_REQUEST)
                else:
                    selected_month = now.replace(day=1).date()
                start_date = datetime.combine(selected_month, datetime.min.time()).replace(tzinfo=tz)
                if selected_month.month == 12:
                    next_month = selected_month.replace(year=selected_month.year + 1, month=1, day=1)
                else:
                    next_month = selected_month.replace(month=selected_month.month + 1, day=1)
                end_date = datetime.combine(next_month, datetime.min.time()).replace(tzinfo=tz)

            elif time_range == 'yearly':
                if year:
                    try:
                        selected_year = int(year)
                    except ValueError:
                        return response.Response({"error": "Invalid year format. Use YYYY."}, status=status.HTTP_400_BAD_REQUEST)
                else:
                    selected_year = now.year
                start_date = datetime(selected_year, 1, 1, tzinfo=tz)
                end_date = datetime(selected_year + 1, 1, 1, tzinfo=tz)
            else:
                return response.Response({"error": "Invalid time range. Choose from 'daily', 'monthly', 'yearly'."}, status=status.HTTP_400_BAD_REQUEST)

            orders = orders.filter(created_at__range=(start_date, end_date))

            if min_price:
                orders = orders.filter(cart__total_price__gte=min_price)

            if max_price:
                orders = orders.filter(cart__total_price__lte=max_price)

            if min_orders:
                orders = orders.filter(cart__total_quantity__gte=min_orders)

            if max_orders:
                orders = orders.filter(cart__total_quantity__lte=max_orders)

            if time_range == 'daily':
                stats = self._generate_daily_stats(orders, restaurant, start_date, end_date)
            elif time_range == 'monthly':
                stats = self._generate_filtered_monthly_stats(orders, start_date, end_date)
            elif time_range == 'yearly':
                stats = self._generate_filtered_yearly_stats(orders, start_date, end_date)
            else:
                return response.Response({"error": "Invalid time range"}, status=status.HTTP_400_BAD_REQUEST)

            return response.Response(stats)

        except Exception as e:
            return response.Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def _generate_filtered_monthly_stats(self, orders, start_date, end_date):
        daily_stats = []
        current_date = start_date
        overall_total_revenue = 0
        overall_total_orders = 0
        overall_total_cancelled = 0
        while current_date < end_date:
            next_day = current_date + timedelta(days=1)
            
            day_orders = orders.filter(
                created_at__range=(current_date, next_day)
            )

            total_orders = day_orders.count()
            cancelled_orders = day_orders.filter(status="CANCELED").count()
            total_revenue = day_orders.aggregate(Sum('cart__total_price'))['cart__total_price__sum'] or 0
            
            overall_total_revenue += total_revenue
            overall_total_orders += total_orders
            overall_total_cancelled += cancelled_orders

            daily_stats.append({
                'day': current_date.strftime('%Y-%m-%d'),
                'total_orders': total_orders,
                'total_revenue': total_revenue,
                'cancelled_orders': cancelled_orders,
                'cancel_rate': (cancelled_orders / total_orders) * 100 if total_orders > 0 else 0,
                'average_order_value': total_revenue / total_orders if total_orders > 0 else 0,
            })

            current_date = next_day

        return {
            'type': 'monthly_filtered',
            'overall_total_revenue': overall_total_revenue,
            'overall_total_orders': overall_total_orders,
            'overall_total_cancelled': overall_total_cancelled,
            'overall_cancel_rate': (overall_total_cancelled / overall_total_orders) * 100 if overall_total_orders > 0 else 0,
            'overall_average_order_value': overall_total_revenue / overall_total_orders if overall_total_orders > 0 else 0,
            'data': daily_stats
        }

    def _generate_filtered_yearly_stats(self, orders, start_date, end_date):
        monthly_stats = []
        current_date = start_date
        overall_total_revenue = 0
        overall_total_orders = 0
        overall_total_cancelled = 0
        while current_date < end_date:
            if current_date.month == 12:
                next_month = current_date.replace(year=current_date.year + 1, month=1, day=1)
            else:
                next_month = current_date.replace(month=current_date.month + 1, day=1)
            
            month_orders = orders.filter(
                created_at__range=(current_date, next_month)
            )

            total_orders = month_orders.count()
            cancelled_orders = month_orders.filter(status="CANCELED").count()
            total_revenue = month_orders.aggregate(Sum('cart__total_price'))['cart__total_price__sum'] or 0
            
            overall_total_revenue += total_revenue
            overall_total_orders += total_orders
            overall_total_cancelled += cancelled_orders

            monthly_stats.append({
                'month': current_date.strftime('%Y-%m'),
                'total_orders': total_orders,
                'total_revenue': total_revenue,
                'cancelled_orders': cancelled_orders,
                'cancel_rate': (cancelled_orders / total_orders) * 100 if total_orders > 0 else 0,
                'average_order_value': total_revenue / total_orders if total_orders > 0 else 0,
            })

            current_date = next_month

        return {
            'type': 'yearly_filtered',
            'overall_total_revenue': overall_total_revenue,
            'overall_total_orders': overall_total_orders,
            'overall_total_cancelled': overall_total_cancelled,
            'overall_cancel_rate': (overall_total_cancelled / overall_total_orders) * 100 if overall_total_orders > 0 else 0,
            'overall_average_order_value': overall_total_revenue / overall_total_orders if overall_total_orders > 0 else 0,
            'data': monthly_stats
        }

    def _generate_daily_stats(self, orders, restaurant, start_date, end_date):
        tz = pytz.timezone(restaurant.detail_info.operating_hours.get('timezone', 'UTC'))
        hourly_stats = []
        current_time = start_date

        overall_total_revenue = 0
        overall_total_orders = 0
        overall_total_cancelled = 0
        while current_time < end_date:
            next_hour = current_time + timedelta(hours=1)

            hour_orders = orders.filter(
                created_at__range=(current_time, next_hour)  
            )

            local_time = current_time.astimezone(tz)
            next_local_time = next_hour.astimezone(tz)

            total_orders = hour_orders.count()
            cancelled_orders = hour_orders.filter(status="CANCELED").count()
            total_revenue = hour_orders.aggregate(Sum('cart__total_price'))['cart__total_price__sum'] or 0
            
            overall_total_revenue += total_revenue
            overall_total_orders += total_orders
            overall_total_cancelled += cancelled_orders

            hourly_stats.append({
                'time_range': f"{local_time.strftime('%Y-%m-%d %H:%M')} - {next_local_time.strftime('%Y-%m-%d %H:%M')}",
                'total_orders': total_orders,
                'total_revenue': total_revenue,
                'cancelled_orders': cancelled_orders,
                'cancel_rate': (cancelled_orders / total_orders) * 100 if total_orders > 0 else 0,
                'average_order_value': total_revenue / total_orders if total_orders > 0 else 0,
            })

            current_time = next_hour

        return {
            'type': 'daily',
            'overall_total_revenue': overall_total_revenue,
            'overall_total_orders': overall_total_orders,
            'overall_total_cancelled': overall_total_cancelled,
            'overall_cancel_rate': (overall_total_cancelled / overall_total_orders) * 100 if overall_total_orders > 0 else 0,
            'overall_average_order_value': overall_total_revenue / overall_total_orders if overall_total_orders > 0 else 0,
            'data': hourly_stats
        }


    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)
        return response.Response(serializer.data, status=status.HTTP_200_OK)

class RestaurantCategoryViewSet(DefaultGenericMixin, viewsets.ModelViewSet):
    queryset = RestaurantCategory.objects.all()
    serializer_class = RestaurantCategorySerializer
    mapping_serializer_class = {
        'create': CreateUpdateRestaurantCategorySerializer,
        'update': CreateUpdateRestaurantCategorySerializer,
    }

class RestaurantLikeViewSet(ForeignKeyFilterMixin, viewsets.ModelViewSet):
    queryset = RestaurantLike.objects.all()
    serializer_class = RestaurantLikeSerializer
    pagination_class = CustomPagination


# first request
# implement a param if time_range is daily a query_params to define which day (default=this day)
# if time_range is month a query_params to define which month (default this month)
# if time_range is month a query_params to define which year (default this year)

# second request
# choose filter by month
# (choose (year-month) to filter default )
# choose filter by day
# (choose (year-month-day) to filter default )
# choose filter by year
# (choose year to filter)
