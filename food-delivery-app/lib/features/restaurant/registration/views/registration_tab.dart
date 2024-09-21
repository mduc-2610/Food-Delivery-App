import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Đăng ký thông tin'),
        bottom: TabBar(
          controller: controller.tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(text: "Thông tin quán - Cơ bản"),
            Tab(text: "Thông tin người đại diện"),
            Tab(text: "Thông tin quán - Chi Tiết"),
            Tab(text: "Menu giao hàng - Ảnh chụp menu"),
            // Tab(text: "Đăng ký Ứng dụng Shopee Partner"),
            Tab(text: "Đăng ký ví ShopeeFood Merchant Wallet"),
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
