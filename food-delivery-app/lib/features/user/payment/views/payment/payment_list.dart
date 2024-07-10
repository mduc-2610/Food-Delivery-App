import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/radio_tick.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/sliver_sized_box.dart';
import 'package:food_delivery_app/features/user/payment/views/payment/widgets/payment_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class PaymentListView extends StatefulWidget {
  @override
  PaymentListViewState createState() => PaymentListViewState();
}

class PaymentListViewState extends State<PaymentListView> {
  int _selectedMethod = -1;

  final List<Map<String, dynamic>> paymentMethods = THardCode.getPaymentList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Payment methods",
          ),

          SliverSizedBox(height: TSize.spaceBetweenItemsVertical,),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return MainWrapper(
                      bottomMargin: TSize.spaceBetweenItemsVertical,
                      child: (index < paymentMethods.length )
                          ? _buildPaymentItem(
                          paymentMethods[index]["icon"],
                          paymentMethods[index]["name"],
                          index, _selectedMethod,
                              (value) {
                            setState(() {
                              if(_selectedMethod == value) {
                                _selectedMethod = -1;
                              }
                              else {
                                _selectedMethod = value!;
                              }
                            });
                          })
                          : ContainerCard(
                        bgColor: TColor.iconBgCancel,
                        borderColor: Colors.transparent,
                        child: ListTile(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return PaymentCard();
                                }
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            TIcon.add,
                            color: TColor.primary,
                          ),
                          title: Text(
                            "Add New Card",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.primary),
                          ),
                        ),
                      )
                  );
                },
                childCount: paymentMethods.length + 1
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainWrapper(
        bottomMargin: TSize.spaceBetweenSections,
        child: Container(
          height: TDeviceUtil.getBottomNavigationBarHeight(),
          child: MainButton(
            onPressed: (_selectedMethod == -1) ? null : () {},
            text: "Apply",
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentItem(IconData icon, String name, int value, int groupValue, Function(int?) onChanged) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: ContainerCard(
        borderColor: !(value == groupValue) ? TColor.borderPrimary : TColor.disable,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: Colors.orange),
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
