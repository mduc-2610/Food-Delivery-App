import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class OrderTracking extends StatelessWidget {
  final Delivery? delivery;
  final bool noDriverInfo;
  final VoidCallback onCancel;
  final controller;

  const OrderTracking({
    this.delivery,
    this.noDriverInfo = false,
    required this.onCancel,
    this.controller
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MainWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(!noDriverInfo)...[
              _driverInfoCard(context, isFind: true,),
              SizedBox(height: TSize.spaceBetweenSections,),
            ],

            Obx(() => _orderTrackingProgressIndicator(context, mapActive: controller.mapActive.value)),
            SizedBox(height: TSize.spaceBetweenSections,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated Delivery Time',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '10:25',
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

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TSize.borderRadiusCircle)
              ),
              child: MainButton(
                onPressed: onCancel,
                text: 'Cancel Order',
                textColor: TColor.reject,
                backgroundColor: Colors.transparent,
                borderColor: Colors.transparent,
                borderRadius: TSize.borderRadiusCircle,
              ),
            ),
            SizedBox(height: TSize.spaceBetweenSections,),

          ],
        ),
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
          SizedBox(width: 16),
          Expanded(
            child: isFind
                ? StreamBuilder<int>(
              stream: _dotStream(),
              builder: (context, snapshot) {
                final dotCount = snapshot.data ?? 0;
                final dots = List.generate(dotCount, (_) => '.').join();
                return Text(
                  'Finding Driver${dots}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                );
              },
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'David Wayne',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    SizedBox(width: TSize.spaceBetweenItemsSm,),
                    Text('4.9'),
                    Text(' · ID 0997125', style: TextStyle(color: Colors.grey)),
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

  Widget _orderTrackingProgressIndicator(BuildContext context, { Map<String, bool> mapActive = const {}}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStep(Icons.person, isActive: true),
        _buildConnector(isActive: controller.mapActive['store'] ?? false),
        _buildStep(Icons.store, isActive: controller.mapActive['store'] ?? false),
        _buildConnector(isActive: controller.mapActive['delivery'] ?? false),
        _buildStep(Icons.delivery_dining, isActive: controller.mapActive['delivery'] ?? false),
        _buildConnector(isActive: controller.mapActive['done'] ?? false),
        _buildStep(Icons.check_circle, isActive: controller.mapActive['done'] ?? false),
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
}