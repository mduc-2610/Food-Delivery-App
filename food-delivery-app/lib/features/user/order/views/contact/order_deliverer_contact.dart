import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/icon_or_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/notification/views/message_room.dart';
import 'package:food_delivery_app/features/user/order/controllers/contact/order_deliverer_contact_controller.dart';
import 'package:food_delivery_app/features/user/order/views/contact/order_calling.dart';
import 'package:food_delivery_app/features/user/order/views/contact/order_message.dart';
import 'package:food_delivery_app/features/user/order/views/contact/widgets/order_deliverer_contact_skeleton.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderDelivererContactView extends StatelessWidget {
  final Deliverer? deliverer;
  final User? user;

  const OrderDelivererContactView({
    this.deliverer,
    this.user
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDelivererContactController>(
      init: OrderDelivererContactController(
        deliverer: deliverer,
        user: user,
      ),
      builder: (controller) {
        return
          Obx(() =>
          (controller.isLoading.value)
              ? OrderDelivererContactSkeleton()
              : Scaffold(
            appBar: CAppBar(
              title: "Deliverer Information",
            ),
            body: MainWrapper(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: TSize.spaceBetweenItemsVertical),

                      THelperFunction.getValidImage(
                        controller.deliverer?.avatar,
                        width: TSize.avatarXl + 20,
                        height: TSize.avatarXl + 20,
                        radius: double.infinity,
                      ),

                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      Text(
                        '${controller.deliverer?.basicInfo?.fullName ?? ""}',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text('${controller.deliverer?.rating} ', style: Theme.of(context).textTheme.titleSmall),
                              SvgPicture.asset(
                                TIcon.fillStar,
                                width: TSize.iconMd,
                                height: TSize.iconMd,
                              )
                            ],
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal * 3,),

                          Text('ID: ${controller.deliverer?.id?.split("-")[0]}', style: Theme.of(context).textTheme.titleSmall),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenSections),
                  SizedBox(height: TSize.spaceBetweenSections),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: CircleIconCard(
                          onTap: () {
                            Get.to(() => OrderCallingView());
                          },
                          elevation: TSize.cardElevation,
                          icon: TIcon.call,
                          iconSize: TSize.iconLg,
                        ),
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                      SizedBox(
                        height: 70,
                        width: 70,
                        child: CircleIconCard(
                          onTap: () {
                            // Get.to(() => OrderMessageView());
                            Get.to(() => MessageRoomView(viewType: ViewType.deliverer,), arguments: {
                              "user1Id": "${controller.user?.id}",
                              "user2Id": "${controller.deliverer?.user}",
                            });
                          },
                          elevation: TSize.cardElevation,
                          icon: TIcon.message,
                          iconSize: TSize.iconLg,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenSections),
                  SizedBox(height: TSize.spaceBetweenSections),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '(+44) 20 1234 5678',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                      IconOrSvg(icon: TIcon.call)
                    ],
                  )
                ],
              ),
            ),
          ));
      },
    );
  }
}
