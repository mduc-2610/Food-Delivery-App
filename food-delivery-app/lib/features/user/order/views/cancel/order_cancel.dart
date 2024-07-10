import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/radio_tick.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_success_dialog.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/sliver_sized_box.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/emoji.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class OrderCancelView extends StatefulWidget {
  @override
  OrderCancelViewState createState() => OrderCancelViewState();
}

class OrderCancelViewState extends State<OrderCancelView> {
  int _selectedMethod = -1;
  bool displayOtherReason = false;
  String text = "";
  TextEditingController controller = TextEditingController();

  final List<Map<String, dynamic>> cancelList = THardCode.getCancelList();

  @override
  Widget build(BuildContext context) {
    print(controller.text);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Cancel Order",
          ),

          SliverSizedBox(height: TSize.spaceBetweenItemsVertical,),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return MainWrapper(
                      bottomMargin: TSize.spaceBetweenItemsVertical,
                      child: _buildCancelItem(
                          cancelList[index]["type"],
                          index, _selectedMethod,
                              (value) {
                            setState(() {
                              if(_selectedMethod == value) {
                                _selectedMethod = -1;
                              }
                              else {
                                _selectedMethod = value!;
                              }
                              if(_selectedMethod == cancelList.length - 1) {
                                displayOtherReason = !displayOtherReason;
                              }
                              else {
                                displayOtherReason = false;
                              }
                            });
                          },
                      )

                  );
                },
                childCount: cancelList.length
            ),
          ),

          SliverToBoxAdapter(
            child: Visibility(
              visible: displayOtherReason,
              child: MainWrapper(
                child: TextFormField(
                  onChanged: (_) {
                    setState(() {
                      controller.text = _;
                    });
                  },
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Other reason ... "
                  ),
                  maxLines: TSize.smMaxLines,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: MainWrapper(
        bottomMargin: TSize.spaceBetweenSections,
        child: Container(
          height: TDeviceUtil.getBottomNavigationBarHeight(),
          child: MainButton(
            onPressed: (_selectedMethod == -1  || ( _selectedMethod == cancelList.length - 1 && controller.text == "" ))
                ? null : () {
              showSuccessDialog(
                context,
                image: TImage.diaHeart,
                head: "Your Order Canceled ${TEmoji.pleadingFace}",
                title: "We're sorry to see your order go.",
                description: "We're always striving to improve, and we hope to serve you better next time!",
              );
              print("SUBMIT");
              print(controller.text);
            },
            text: "Submit",
          ),
        ),
      ),
    );
  }

  Widget _buildCancelItem(String name, int value, int groupValue, Function(int?) onChanged, { VoidCallback? other }) {
    return InkWell(
      onTap: () {
        onChanged(value);
        other?.call();
      },
      child: ContainerCard(
        borderColor: !(value == groupValue) ? TColor.borderPrimary : TColor.disable,
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
