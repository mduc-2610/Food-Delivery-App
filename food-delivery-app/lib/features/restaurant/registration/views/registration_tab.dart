import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/skeleton/registration_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_tab_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_basic_info.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_detail_info.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_email_login.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_menu_delivery.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_payment.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_representative_info.dart';

class RegistrationTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationTabController());
    return Scaffold(
      appBar: CAppBar(
        title: 'Restaurant Registration',
        bottom: TabBar(
          controller: controller.tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(child: Text("Basic Information", style: Get.textTheme.bodyMedium)),
            Tab(child: Text("Representative Information", style: Get.textTheme.bodyMedium)),
            Tab(child: Text("Detail Information", style: Get.textTheme.bodyMedium)),
            Tab(child: Text("Menu Delivery - Menu Image", style: Get.textTheme.bodyMedium)),
            // Tab(child: Text("Shopee Partner", style: Get.textTheme.bodyMedium)),
            Tab(child: Text("Wallet", style: Get.textTheme.bodyMedium)),
            // Tab(text: "Basic Information",),
            // Tab(text: "Representative Information",),
            // Tab(text: "Detail Information",),
            // Tab(text: "Menu Delivery - Menu Image",),
            // // Tab(text: "Đăng ký Ứng dụng Shopee Partner"),
            // Tab(text: "Wallet"),
          ],
        ),
      ),
      body: Obx(() => TabBarView(
        controller: controller.tabController,
        children: [
          controller.isLoading.value ? RegistrationSkeleton() : RegistrationBasicInfo(),
          controller.isLoading.value ? RegistrationSkeleton() : RegistrationRepresentativeInfo(),
          controller.isLoading.value ? RegistrationSkeleton() : RegistrationDetailInfo(),
          controller.isLoading.value ? RegistrationSkeleton() : RegistrationMenuDelivery(),
          // controller.isLoading.value ? RegistrationSkeleton() : RegistrationEmailLogin(),
          controller.isLoading.value ? RegistrationSkeleton() : RegistrationPaymentInfo(),
        ],
      )),
    );
  }
}
