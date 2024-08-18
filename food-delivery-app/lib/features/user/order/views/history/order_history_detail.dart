import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/delivery_detail.dart';
import 'package:food_delivery_app/features/user/order/views/history/widgets/order_history_detail_card.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class OrderHistoryDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "SP 0023502",
            iconList: [
              {
                "icon": Icons.more_horiz
              }
            ],
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                OrderHistoryDetailCard(
                  name: "Chicken Burger",
                  imageUrl: "https://via.placeholder.com/150",
                  originalPrice: 10.0,
                  discountedPrice: 6.0,
                  options: ['Add Cheese: £0.50', 'Add Meat (Extra Patty): £2.00'],
                  review: "Chicken burger is delicious! I will save it for next order.",
                  rating: 5,
                  isCompletedOrder: false,
                ),
                OrderHistoryDetailCard(
                  name: "Ramen Noodles",
                  imageUrl: "https://via.placeholder.com/150",
                  originalPrice: 22.0,
                  discountedPrice: 15.0,
                  review: "Chicken burger is delicious! I will save it for next order.",
                  rating: 5,
                  isCompletedOrder: false,
                ),
                OrderHistoryDetailCard(
                  name: "Cherry Tomato Salad",
                  imageUrl: "https://via.placeholder.com/150",
                  originalPrice: 8.0,
                  discountedPrice: 10,
                  review: "Chicken burger is delicious! I will save it for next order.",
                  rating: 5,
                  isCompletedOrder: false,
                ),
                SizedBox(height: TSize.spaceBetweenSections,),

                // DeliveryDetail(
                //   address: "221B Baker Street, London, United Kingdom",
                //   paymentMethod: "Cash",
                //   subtotal: 31.50,
                //   discount: 6.30,
                //   total: 25.20,
                // ),
                SizedBox(height: TSize.spaceBetweenSections,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

