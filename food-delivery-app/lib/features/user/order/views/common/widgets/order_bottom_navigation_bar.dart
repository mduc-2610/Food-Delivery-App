import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/animation/text_with_dot_animation.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/order/controllers/common/order_info_controller.dart';
import 'package:food_delivery_app/features/user/order/controllers/common/order_bottom_navigation_bar_controller.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class OrderBottomNavigationBar extends StatelessWidget {
  final Order? order;
  final OrderViewType viewType;

  const OrderBottomNavigationBar({
    this.order,
    this.viewType = OrderViewType.cancel,
  });

  @override
  Widget build(BuildContext context) {

    return GetBuilder<OrderBottomNavigationBarController>(
      init: OrderBottomNavigationBarController(order: order,viewType: viewType,),
      builder: (controller) {
        return MainWrapper(
          topMargin: TSize.spaceBetweenItemsVertical,
          bottomMargin: TSize.spaceBetweenItemsVertical + 5,
          child: SingleChildScrollView(
            child: Row(
              children: [
                if (controller.order?.status == "COMPLETED")...[
                  Expanded(
                    child: MainButton(
                      onPressed: () async {
                        await controller.reorder();
                      },
                      text: "Reorder",
                      prefixIconStr: TIcon.fillCart,
                      backgroundColor: TColor.secondary,
                      borderColor: TColor.secondary,
                      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
                    ),
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsVertical),
                ],
                if (controller.order?.status == "ACTIVE" && controller.order?.cancellation == null)...[
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        await controller.cancelOrder();
                      },
                      child: Text(
                        "Cancel Order",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.textDesc),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsVertical),
                ],
                if (controller.order?.status == "ACTIVE" && controller.order?.cancellation == null)...[
                  Expanded(
                    child: MainButton(
                      paddingHorizontal: TSize.lg,
                      onPressed: () async {
                        await controller.trackOrder(context);
                      },
                      text: "Track Order",
                      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
                    ),
                  ),
                ],
                if (controller.order?.status == "PENDING")...[
                  Expanded(
                    child: MainButton(
                      paddingHorizontal: TSize.lg,
                      onPressed: () async {
                        await controller.handlePendingOrder(context);
                      },
                      text: "Order",
                      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
                    ),
                  ),
                ],
                if (controller.order?.cancellation != null)...[
                  Expanded(
                    child: Column(
                      children: [
                        if ((viewType == OrderViewType.history && order?.status == "CANCELLED") || order?.cancellation != null)...[
                          _buildCancellationSection(context, controller, order?.cancellation?.reason),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),
                        ],

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: controller.isCancellationPending() ? Color(0xfffbc972) : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: controller.isCancellationPending()
                              ? TextWithDotAnimation(text: "Waiting for response")
                              : Text(
                            controller.getCancellationStatusText(),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TColor.success),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCancellationSection(BuildContext context, OrderBottomNavigationBarController controller, String? reason) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reason for Cancellation', style: Theme.of(context).textTheme.titleSmall),
              Text('${reason ?? ''}', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        CircleIconCard(
          onTap: controller.onCancelOrderTapped,
          icon: Icons.edit,
          iconColor: TColor.light,
          backgroundColor: TColor.primary,
        ),

        CircleIconCard(
          onTap: controller.deleteCancelRequest,
          icon: TIcon.delete,
          iconColor: TColor.light,
          backgroundColor: TColor.error,
        ),
      ],
    );
  }
}

class OrderBottomNavigationBarSkeleton extends StatelessWidget {
  const OrderBottomNavigationBarSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // BoxSkeleton(
        //   height: 40,
        //   width: 120,
        // ),
        // SizedBox(width: TSize.spaceBetweenSections),
        // BoxSkeleton(
        //   height: 40,
        //   width: 180,
        // ),
      ],
    );;
  }
}
