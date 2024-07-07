import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/container_card.dart';
import 'package:food_delivery_app/common/widgets/main_button.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/radio_tick.dart';
import 'package:food_delivery_app/common/widgets/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/sliver_sized_box.dart';
import 'package:food_delivery_app/features/payment/views/payment/widgets/payment_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class PaymentListView extends StatefulWidget {
  @override
  PaymentListViewState createState() => PaymentListViewState();
}

class PaymentListViewState extends State<PaymentListView> {
  int _selectedMethod = 0;

  final List<Map<String, dynamic>> paymentMethods = [
    {'icon': Icons.money, 'name': 'Cash'},
    {'icon': Icons.account_balance_wallet, 'name': 'PayPal'},
    {'icon': Icons.account_balance_wallet, 'name': 'Google Pay'},
    {'icon': Icons.account_balance_wallet, 'name': 'Apple Pay'},
    {'icon': Icons.credit_card, 'name': '**** **** **** 0895'},
    {'icon': Icons.credit_card, 'name': '**** **** **** 2259'},
  ];

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
                              _selectedMethod = value!;
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
            onPressed: () {},
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
