import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/order/controllers/cancel/order_cancel_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/radio_tick.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/sliver_sized_box.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/emojis.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class OrderCancelView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderCancelController>(
        init: OrderCancelController(),
        builder: (controller) {
          return CustomScrollView(
            slivers: [
              CSliverAppBar(title: "Cancel Order"),
              SliverSizedBox(height: TSize.spaceBetweenItemsVertical),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return MainWrapper(
                      bottomMargin: TSize.spaceBetweenItemsVertical,
                      child: _buildCancelItem(
                        controller.cancelList[index]["type"],
                        index,
                        controller.selectedMethod,
                        controller.updateSelectedMethod,
                      ),
                    );
                  },
                  childCount: controller.cancelList.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Visibility(
                  visible: controller.displayOtherReason,
                  child: MainWrapper(
                    child: TextFormField(
                      controller: controller.otherReasonController,
                      decoration: InputDecoration(hintText: "Other reason ... "),
                      maxLines: TSize.smMaxLines,
                      onChanged: (_) => controller.update(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<OrderCancelController>(
        builder: (controller) {
          return MainWrapper(
            bottomMargin: TSize.spaceBetweenSections,
            child: Container(
              height: TDeviceUtil.getBottomNavigationBarHeight(),
              child: MainButton(
                onPressed: controller.isSubmitEnabled
                    ? () {
                  showConfirmDialog(
                    context,
                    onAccept: () async {
                      await controller.handleSubmit();
                      Get.back();
                    },
                    title: "Are you sure you want to cancel this order ${TEmoji.faceSad}?",
                    description: "You have to wait for restaurant to response",
                  );
                }
                    : null,
                text: "Submit",
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCancelItem(String name, int value, int groupValue, Function(int?) onChanged) {
    return InkWell(
      onTap: () => onChanged(value),
      child: ContainerCard(
        borderColor: value != groupValue ? TColor.borderPrimary : TColor.disable,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(name),
          trailing: RadioTick(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}