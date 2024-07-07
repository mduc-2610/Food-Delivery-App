import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/radio_tick.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/order/views/promotion/order_promotion_detail.dart';
import 'package:food_delivery_app/features/order/views/promotion/order_promotion_list.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class OrderPromotionView extends StatefulWidget {
  @override
  _OrderPromotionViewState createState() => _OrderPromotionViewState();
}

class _OrderPromotionViewState extends State<OrderPromotionView> {
  int selected = 1;
  int selected2 = 1;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Promotions",
          ),
          SliverToBoxAdapter(
            child: MainWrapper(
              topMargin: TSize.spaceBetweenItemsVertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Promo Code',
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MainWrapper(
                                  child: InkWell(
                                    onTap: () {
                                      // Apply promo code logic
                                    },
                                    child: Text(
                                      'Apply',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TColor.primary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenSections),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              MainWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shipping Offers', style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),
                    _buildPromotionItem('FREE SHIPPING', 1, selected, (value) {
                      setState(() {
                        selected = (selected == value) ? -1 : value!;
                      });
                    }),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),
                    _buildPromotionItem('20% OFF', 2, selected, (value) {
                      setState(() {
                        selected = (selected == value) ? -1 : value!;
                      });
                    }),
                    SizedBox(height: TSize.spaceBetweenSections),
                    Text('Order Offers', style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),
                    _buildPromotionItem('20% OFF', 1, selected2, (value) {
                      setState(() {
                        selected2 = (selected2 == value) ? -1 : value!;
                      });
                    }),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),
                    _buildPromotionItem('10% OFF', 2, selected2, (value) {
                      setState(() {
                        selected2 = (selected2 == value) ? -1 : value!;
                      });
                    }),
                    SizedBox(height: TSize.spaceBetweenSections),
                    ContainerCard(
                      bgColor: TColor.iconBgCancel,
                      borderColor: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => OrderPromotionListView());
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          TIcon.add,
                          color: TColor.primary,
                        ),
                        title: Text(
                          "Get more promotions",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ]
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

  Widget _buildPromotionItem(String title, int value, int groupValue, Function(int?) onChanged) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: ContainerCard(
        borderColor: !(value == groupValue) ? TColor.borderPrimary : TColor.disable,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return PromotionInformationPage();
                },
              );
            },
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: !(value == groupValue) ? TColor.disable : null),
            ),
          ),
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
