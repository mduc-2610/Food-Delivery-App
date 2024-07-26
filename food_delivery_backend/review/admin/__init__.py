from django.contrib import admin

from .review import (
    DeliveryReviewAdmin,
    DishReviewAdmin,
    RestaurantReviewAdmin,
    DelivererReviewAdmin
)
from .review_like import (
    DishReviewLikeAdmin,
    RestaurantReviewLikeAdmin,
    DelivererReviewLikeAdmin,
    DeliveryReviewLikeAdmin,
)

from review.models import (
    DeliveryReview,
    DishReview,
    RestaurantReview,
    DelivererReview,
    DishReviewLike,
    RestaurantReviewLike,
    DelivererReviewLike,
    DeliveryReviewLike
)

admin.site.register(DeliveryReview, DeliveryReviewAdmin)
admin.site.register(DishReview, DishReviewAdmin)
admin.site.register(RestaurantReview, RestaurantReviewAdmin)
admin.site.register(DelivererReview, DelivererReviewAdmin)

admin.site.register(DeliveryReviewLike, DeliveryReviewLikeAdmin)
admin.site.register(DishReviewLike, DishReviewLikeAdmin)
admin.site.register(RestaurantReviewLike, RestaurantReviewLikeAdmin)
admin.site.register(DelivererReviewLike, DelivererReviewLikeAdmin)
