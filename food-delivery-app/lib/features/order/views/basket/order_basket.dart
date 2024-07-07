import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/order/views/basket/widgets/order_card.dart';
import 'package:food_delivery_app/features/order/views/common/widgets/delivery_detail.dart';
import 'package:food_delivery_app/features/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class OrderBasketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "My Basket",
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                MainWrapper(
                  topMargin: TSize.spaceBetweenItemsVertical,
                  bottomMargin: TSize.spaceBetweenItemsVertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order summary',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                  
                      StatusChip(status: 'Active')
                    ],
                  ),
                ),
                OrderCard(
                  name: "Chicken Burger",
                  imageUrl: "https://via.placeholder.com/150",
                  originalPrice: 10.0,
                  discountedPrice: 6.0,
                  options: ['Add Cheese: £0.50', 'Add Meat (Extra Patty): £2.00'],
                  review: "Chicken burger is delicious! I will save it for next order.",
                  rating: 5,
                  isCompletedOrder: false,
                ),
                OrderCard(
                  name: "Ramen Noodles",
                  imageUrl: "https://via.placeholder.com/150",
                  originalPrice: 22.0,
                  discountedPrice: 15.0,
                  review: "Chicken burger is delicious! I will save it for next order.",
                  rating: 5,
                  isCompletedOrder: false,
                ),
                OrderCard(
                  name: "Cherry Tomato Salad",
                  imageUrl: "https://via.placeholder.com/150",
                  originalPrice: 8.0,
                  discountedPrice: 10,
                  review: "Chicken burger is delicious! I will save it for next order.",
                  rating: 5,
                  isCompletedOrder: false,
                ),
                SizedBox(height: TSize.spaceBetweenSections,),

                DeliveryDetail(
                  address: "221B Baker Street, London, United Kingdom",
                  paymentMethod: "Cash",
                  subtotal: 31.50,
                  discount: 6.30,
                  total: 25.20,
                  fromView: "Basket",
                ),
                SizedBox(height: TSize.spaceBetweenSections,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

