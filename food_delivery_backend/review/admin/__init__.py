from django.contrib import admin

from .review import (
    OrderReviewAdmin,
    DishReviewAdmin,
    RestaurantReviewAdmin,
    DelivererReviewAdmin
)
from .review_like import (
    OrderReviewLikeAdmin,
    DishReviewLikeAdmin,
    RestaurantReviewLikeAdmin,
    DelivererReviewLikeAdmin
)

from review.models import (
    OrderReview,
    DishReview,
    RestaurantReview,
    DelivererReview,
    OrderReviewLike,
    DishReviewLike,
    RestaurantReviewLike,
    DelivererReviewLike
)

admin.site.register(OrderReview, OrderReviewAdmin)
admin.site.register(DishReview, DishReviewAdmin)
admin.site.register(RestaurantReview, RestaurantReviewAdmin)
admin.site.register(DelivererReview, DelivererReviewAdmin)

admin.site.register(OrderReviewLike, OrderReviewLikeAdmin)
admin.site.register(DishReviewLike, DishReviewLikeAdmin)
admin.site.register(RestaurantReviewLike, RestaurantReviewLikeAdmin)
admin.site.register(DelivererReviewLike, DelivererReviewLikeAdmin)
