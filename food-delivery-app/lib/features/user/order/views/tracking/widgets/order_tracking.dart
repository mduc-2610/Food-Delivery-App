import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/animation/text_with_dot_animation.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/deliverer/delivery/controllers/delivery/delivery_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

enum OrderTrackingType { deliverer, user }

class OrderTracking extends StatelessWidget {
  final Delivery? delivery;
  final VoidCallback onCancel;
  final OrderTrackingType type;
  final controller;

  const OrderTracking({
    this.delivery,
    required this.onCancel,
    this.controller,
    this.type = OrderTrackingType.user
  });

  @override
  Widget build(BuildContext context) {
    final forTrackingStage = controller is DeliveryController ? controller.delivererHomeController : controller;
    return SingleChildScrollView(
      child: MainWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(type == OrderTrackingType.user)...[
              Obx(() => _driverInfoCard(context, isFind: controller.deliverer.value == null,)),
              SizedBox(height: TSize.spaceBetweenSections,),
            ]
            else...[
              _userInfoCard(context),
              SizedBox(height: TSize.spaceBetweenSections,),
            ],

            Obx(() => _orderTrackingProgressIndicator(context, stage: forTrackingStage.trackingStage.value)),
            SizedBox(height: TSize.spaceBetweenSections,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated Delivery Time',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${delivery?.formatEstimatedDeliveryTime}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My order',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                StatusChip(
                  status: 'ACTIVE',
                  text: 'Detail',
                  onTap: () {},
                  paddingHorizontal: 20,
                  paddingVertical: 5,
                )
              ],
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical,),

            Obx(() => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TSize.borderRadiusCircle)
              ),
              child: MainButton(
                onPressed: (forTrackingStage.trackingStage.value < 3)
                    ? onCancel
                    : type == OrderTrackingType.user
                    ? null
                    : () => controller.handleCompleteOrder(),
                text: (forTrackingStage.trackingStage.value < 3)
                    ? 'Cancel Order'
                    : type == OrderTrackingType.user
                    ? 'Completed'
                    : 'Complete Order',
                textColor: (forTrackingStage.trackingStage.value < 3)
                    ? TColor.reject
                    : TColor.complete,
                backgroundColor: Colors.transparent,
                borderColor: Colors.transparent,
                borderRadius: TSize.borderRadiusCircle,
              ),
            )),
            SizedBox(height: TSize.spaceBetweenSections,),
          ],
        ),
      ),
    );
  }

  Widget _orderTrackingProgressIndicator(BuildContext context, {int stage = 0}) {
    final steps = [
      {'icon': Icons.person, 'isActive': stage >= 0},
      {'icon': Icons.store, 'isActive': stage >= 1},
      {'icon': Icons.delivery_dining, 'isActive': stage >= 2},
      {'icon': Icons.check_circle, 'isActive': stage >= 3},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          _buildStep(steps[i]['icon'] as IconData, isActive: steps[i]['isActive'] as bool),
          if (i < steps.length - 1)
            _buildConnector(isActive: (stage > i)),
        ],
      ],
    );
  }

  Widget _buildStep(IconData icon, {bool isActive = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: isActive ? TColor.primary : Colors.grey.shade300,
          child: Icon(
            icon,
            color: isActive ? Colors.white : Colors.grey,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector({bool isActive = false}) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? TColor.primary : Colors.grey.shade300,
      ),
    );
  }

  Widget _userInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xfffbc972),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.orangeAccent.withOpacity(0.8),
            child:
            (delivery?.user?.avatar != null)
            ? ClipRRect(
              borderRadius: BorderRadius.circular(TSize.borderRadiusCircle),
              child: Image.network(
                "${delivery?.user?.avatar}"
              ),
            )
            : Icon(
              Icons.person,
              color: Colors.white,
            )
          ),
          SizedBox(width: TSize.spaceBetweenItemsVertical),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${delivery?.user?.name}',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: Color(0xfffcd899),
            child: IconButton(
              icon: Icon(Icons.chat, color: TColor.dark),
              onPressed: () {},
            ),
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

          CircleAvatar(
            backgroundColor: Color(0xfffcd899),
            child: IconButton(
              icon: Icon(Icons.phone, color: TColor.dark),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _driverInfoCard(BuildContext context, {bool isFind = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xfffbc972),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.orangeAccent.withOpacity(0.8),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          SizedBox(width: TSize.spaceBetweenItemsVertical),
          Expanded(
            child: isFind
                ? TextWithDotAnimation(
                  text: "Finding driver",
                )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.deliverer.value.basicInfo.giveName} ${controller.deliverer.value.basicInfo.fullName}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    SizedBox(width: TSize.spaceBetweenItemsSm,),
                    Text('${controller.deliverer.value.rating}'),
                    // Text(' · ID 0997125', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          if (!isFind) ...[
            CircleAvatar(
              backgroundColor: Color(0xfffcd899),
              child: IconButton(
                icon: Icon(Icons.chat, color: TColor.dark),
                onPressed: () {},
              ),
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

            CircleAvatar(
              backgroundColor: Color(0xfffcd899),
              child: IconButton(
                icon: Icon(Icons.phone, color: TColor.dark),
                onPressed: () {},
              ),
            ),
          ],
        ],
      ),
    );
  }

  Stream<int> _dotStream() async* {
    int dotCount = 0;
    while (true) {
      yield dotCount;
      dotCount = (dotCount + 1) % 8;
      await Future.delayed(Duration(milliseconds: 500));
    }
  }
}
