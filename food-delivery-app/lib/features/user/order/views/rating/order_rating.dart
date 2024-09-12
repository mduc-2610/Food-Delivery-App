import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/order/views/rating/widgets/order_restaurant_information.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/controllers/rating/order_rating_controller.dart';
import 'package:food_delivery_app/features/user/order/views/rating/widgets/order_deliverer_information.dart';
import 'package:food_delivery_app/features/user/order/views/rating/widgets/order_deliverer_tip.dart';
import 'package:food_delivery_app/features/user/order/views/rating/widgets/order_food_rating_card.dart';
import 'package:food_delivery_app/features/user/order/views/rating/widgets/order_rating_review.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class OrderRatingView extends StatelessWidget {
  final OrderRatingController controller = Get.put(OrderRatingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderRatingController>(
      builder: (controller) => Scaffold(
        appBar: CAppBar(
          title: 'Rate Your Experience',
          result: {
            "isUpdated": controller.isUpdated,
          },
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: controller.tabController,
            tabs: [
              _buildTab('Order', 0),
              _buildTab('Deliverer', 1),
              _buildTab('Restaurant', 2),
              _buildTab('Tip', 3),
              _buildTab('Meal', 4),
            ],
          ),
        ),
        body: MainWrapper(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              _buildOrderRatingStep(),
              _buildDelivererRatingStep(),
              _buildRestaurantRatingStep(),
              _buildDelivererTipStep(),
              _buildMealRatingStep(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          if (!controller.isTabRated(index))
            Container(
              margin: EdgeInsets.only(left: 5),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return MainWrapper(
      bottomMargin: TSize.spaceBetweenItemsXl,
      child: ElevatedButton(
      onPressed: controller.handleSubmitReview,
      child: Text("Submit"),
            ),
    );
  }

  Widget _buildCommonRatingWidget({required Widget child}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TSize.spaceBetweenItemsSm),
        child: Column(
          children: [
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            child,
            SizedBox(height: TSize.spaceBetweenSections),
            RatingReview(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderRatingStep() {
    return _buildCommonRatingWidget(
      child: Column(
        children: [
          Text(
            'Rate your Experience',
            style: Get.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: TSize.spaceBetweenSections),
          Image.asset(
            TImage.deDiamond,
            width: TDeviceUtil.getScreenWidth() * 0.5,
            height: TDeviceUtil.getScreenHeight() * 0.2,
          ),
        ],
      ),
    );
  }

  Widget _buildDelivererRatingStep() {
    return _buildCommonRatingWidget(
      child: OrderDelivererInformation(
        head: "Rate your deliverer's service",
        deliverer: controller.order.value?.deliverer,
      ),
    );
  }

  Widget _buildRestaurantRatingStep() {
    return _buildCommonRatingWidget(
      child: OrderRestaurantInformation(
        head: "Rate your restaurant's service",
        restaurant: controller.order.value?.restaurant,
      ),
    );;
  }

  Widget _buildDelivererTipStep() {
    return Padding(
      padding: EdgeInsets.all(TSize.spaceBetweenItemsSm),
      child: Column(
        children: [
          SizedBox(height: TSize.spaceBetweenItemsVertical),
          OrderDelivererInformation(
            head: 'Tip your delivery driver',
            deliverer: controller.order.value?.deliverer,
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical),
          OrderDelivererTip(),
        ],
      ),
    );
  }

  Widget _buildMealRatingStep() {
    return ListView(
      padding: EdgeInsets.all(TSize.spaceBetweenItemsSm),
      children: [
        SizedBox(height: TSize.spaceBetweenItemsVertical),
        for(int i = 0; i < controller.order.value?.cart?.cartDishes?.length; i++)...[
          OrderFoodRatingCard(
            dish: controller.order.value?.cart?.cartDishes[i].dish,
          ),
        ]
      ],
    );
  }
}
