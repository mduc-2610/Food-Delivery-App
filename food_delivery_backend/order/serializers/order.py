from rest_framework import serializers
from order.models import (
    Order, 
    OrderCancellation,
    RestaurantCart, 
    Promotion, 
)
from review.models import (
    DishReview, 
    DelivererReview, 
    RestaurantReview
)
from deliverer.models import Deliverer

from account.serializers import UserLocationSerializer
from utils.serializers import CustomRelatedModelSerializer
    
class OrderCancellationSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderCancellation
        fields = ['id', 'order', 'user', 'restaurant', 'reason', 'is_accepted', 'created_at', 'updated_at']
        read_only_fields = [
            'id', 
            'created_at',
            'updated_at'
        ]


class OrderSerializer(serializers.ModelSerializer):
    cancellation = OrderCancellationSerializer(read_only=True)
    delivery_address = UserLocationSerializer(read_only=True)
    
    class Meta:
        model = Order
        fields = [
            'id', 
            'cart', 
            'user', 
            'delivery',
            'cancellation', 
            'delivery_address', 
            'payment_method', 
            'promotion',
            'delivery_fee', 
            'discount', 
            'total_price', 
            'total', 
            'status', 
            'rating',
            'created_at',
            'is_reviewed', 'is_order_reviewed', 'is_dish_reviewed', 'is_deliverer_reviewed', 'is_restaurant_reviewed'
        ]
        read_only_fields = ['total']

    def to_representation(self, instance):
        data = super().to_representation(instance)
        from order.serializers.basic import BasicRestaurantCartSerializer
        data['cart'] = BasicRestaurantCartSerializer(instance.cart).data
        return data
    
    # def create(self, validated_data):
    #     order = super().create(validated_data)
    #     order.calculate_total()  # Calculate total on creation
    #     return order

    # def update(self, instance, validated_data):
    #     instance.delivery_address = validated_data.get('delivery_address', instance.delivery_address)
    #     instance.payment_method = validated_data.get('payment_method', instance.payment_method)
    #     instance.promotion = validated_data.get('promotion', instance.promotion)
    #     instance.delivery_fee = validated_data.get('delivery_fee', instance.delivery_fee)
    #     instance.discount = validated_data.get('discount', instance.discount)
    #     instance.status = validated_data.get('status', instance.status)
    #     instance.calculate_total()  # Recalculate total on update
    #     instance.save()
    #     return instance

class DetailOrderSerializer(CustomRelatedModelSerializer):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        from order.serializers.basic import BasicRestaurantCartSerializer
        self.one_related_serializer_class = {
            'cart': BasicRestaurantCartSerializer,
            # 'delivery_address': UserLocationSerializer,
            'cancellation': OrderCancellationSerializer,
        }
    
    dish_reviews = serializers.SerializerMethodField()
    deliverer_review = serializers.SerializerMethodField()
    restaurant_review = serializers.SerializerMethodField()
    deliverer = serializers.SerializerMethodField()
    restaurant = serializers.SerializerMethodField()
    delivery_address = UserLocationSerializer(read_only=True)
    
    def get_dish_reviews(self, obj):
        from review.serializers import DishReviewSerializer
        if hasattr(obj, 'dish_reviews'):
            dish_reviews = obj.dish_reviews.all()
            return DishReviewSerializer(dish_reviews, many=True, context=self.context).data
        return None

    def get_deliverer_review(self, obj):
        from review.serializers import DelivererReviewSerializer
        if hasattr(obj, 'deliverer_review'):
            deliverer_review = obj.deliverer_review
            return DelivererReviewSerializer(deliverer_review, context=self.context).data
        return {}

    def get_restaurant_review(self, obj):
        from review.serializers import RestaurantReviewSerializer
        if hasattr(obj, 'restaurant_review'):
            restaurant_review = obj.restaurant_review
            return RestaurantReviewSerializer(restaurant_review, context=self.context).data
        return {}

    def get_deliverer(self, obj):
        from deliverer.serializers import BasicDelivererSerializer
        if hasattr(obj, 'delivery') or obj.status == "COMPLETED":
            return BasicDelivererSerializer(obj.delivery.deliverer, context=self.context).data
        return None

    def get_restaurant(self, obj):
        from restaurant.serializers import BasicRestaurantSerializer
        if hasattr(obj, 'cart') and obj.cart.restaurant:
            return BasicRestaurantSerializer(obj.cart.restaurant, context=self.context).data
        return None


    class Meta:
        model = Order
        fields = [
            'id', 
            'deliverer',
            'restaurant',
            'payment_method', 
            'promotion', 
            'dish_reviews',
            'deliverer_review',
            'delivery_address',
            'restaurant_review',
            'delivery_fee', 
            'discount', 
            'total_price', 
            'total', 
            "user",
            'status', 
            'rating', 
            'is_reviewed', 
            'is_order_reviewed', 
            'is_dish_reviewed', 
            'is_deliverer_reviewed',
            'is_restaurant_reviewed',
        ]


class CreateOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ['cart']
        
    def create(self, validated_data):
        cart = validated_data.pop('cart', None)
        request = self.context.get('request', None)
        delivery_address = None
        print(request.user, pretty=True)
        if request is not None and hasattr(request, 'user'):
            delivery_address = request.user.locations.filter(is_selected=True).first()
        
        print(delivery_address, pretty=True)
        
        order, created = Order.objects.get_or_create(cart=cart)
        order.cart.is_created_order = True
        if delivery_address:
            order.delivery_address = delivery_address
            order.save()

        order.cart.save() 
        print(order)
        return order

    def to_representation(self, instance):
        # if condition:
        data = OrderSerializer(instance).data
        
        # from order.serializers import RestaurantCartSerializer
        # data = RestaurantCartSerializer(instance.cart).data

        return data

class UpdateOrderSerializer(serializers.ModelSerializer):
    dish_reviews = serializers.ListField(
        child=serializers.DictField(
            write_only=True,
            required=False,
        ),
        write_only=True,
        required=False
    )
    deliverer_review = serializers.DictField(required=False)
    restaurant_review = serializers.DictField(required=False)
    
    class Meta:
        model = Order
        fields = [
            'rating', 
            'dish_reviews', 
            'deliverer_review',
            'restaurant_review',
        ]
    
    def update(self, instance, validated_data):

        dish_reviews = validated_data.pop('dish_reviews', [])
        deliverer_review = validated_data.pop('deliverer_review', None)
        restaurant_review = validated_data.pop('restaurant_review', None)
        
        #instance: Order
        instance = super().update(instance, validated_data)

        for dish_review in dish_reviews:
            _user = dish_review.pop('user', None)
            _dish = dish_review.pop('dish', None)
            _order = dish_review.pop('order', None)
            _instance, _updated = DishReview.objects.update_or_create(
                user=_user if _user else instance.user,
                order=_order if _order else instance,
                dish_id=_dish,
                defaults=dish_review
            )
            print(_instance.id, _updated, pretty=True)
        
        if deliverer_review:
            _user = deliverer_review.pop('user', None)
            _deliverer = deliverer_review.pop('deliverer', None)
            _order = deliverer_review.pop('order', None)
            _instance, _updated = DelivererReview.objects.update_or_create(
                user=_user if _user else instance.user,
                order=_order if _order else instance,
                deliverer=_deliverer if _deliverer else instance.delivery.deliverer,
                defaults=deliverer_review
            )
            print(_instance.id, _updated, pretty=True)
        
        if restaurant_review:
            _user = restaurant_review.pop('user', None)
            _restaurant = restaurant_review.pop('restaurant', None)
            _order = restaurant_review.pop('order', None)
            _instance, _updated = RestaurantReview.objects.update_or_create(
                user=_user if _user else instance.user,
                order=_order if _order else instance,
                restaurant=_restaurant if _restaurant else instance.cart.restaurant,
                defaults=restaurant_review
            )
            print(_instance.id, _instance.rating, _updated, pretty=True)

        return instance
    
    def to_representation(self, instance):
        return DetailOrderSerializer(instance, context=self.context).data