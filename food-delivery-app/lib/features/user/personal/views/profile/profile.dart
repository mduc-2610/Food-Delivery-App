import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/sliver_sized_box.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/views/login/login.dart';
import 'package:food_delivery_app/features/authentication/views/profile/widgets/profile_detail.dart';
import 'package:food_delivery_app/features/personal/views/profile/widgets/personal_setting.dart';
import 'package:food_delivery_app/features/user/personal/controller/personal_profile_controller.dart';
import 'package:food_delivery_app/features/user/personal/views/profile/widgets/personal_setting_skeleton.dart';
import 'package:food_delivery_app/features/user/personal/views/profile/widgets/profile_skeleton.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class PersonalProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalProfileController>(
      init: PersonalProfileController(),
      builder: (controller) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              CSliverAppBar(
                title: "Profile",
                iconList: [
                  {
                    "icon": Icons.more_horiz
                  }
                ],
                noLeading: true,
              ),
              SliverToBoxAdapter(
                child: MainWrapper(
                  child: Column(
                    children: [
                      Obx(() => controller.isLoading.value
                          ? ProfileSkeleton()
                          : ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.user?.profile?.name}',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                            ),
                            Text(
                              '${THelperFunction.hidePhoneNumber(controller.user?.phoneNumber ?? "")}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        trailing: CircleIconCard(
                          onTap: () {
                            showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {
                              return MainWrapper(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ProfileDetail(
                                        isEdit: true,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                          icon: Icons.edit,
                          iconColor: TColor.light,
                          backgroundColor: TColor.primary,
                        ),
                        onTap: () {},
                      )),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      MainButton(
                        onPressed: () async {
                          await TokenService.deleteToken();
                          Get.offAll(() => LoginView());
                        },
                        text: "Logout",
                        textColor: TColor.primary,
                        height: TSize.buttonHeight + 6,
                        paddingHorizontal: 0,
                        prefixIcon: Icons.logout,
                        prefixIconColor: TColor.primary,
                        backgroundColor: TColor.iconBgCancel,
                      ),
                    ],
                  ),
                ),
              ),
              SliverSizedBox(height: TSize.spaceBetweenItemsVertical),
              SliverToBoxAdapter(
                child: MainWrapper(
                  child: Obx(() => controller.isLoading.value ? PersonalSettingSkeleton() : PersonalSetting()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
