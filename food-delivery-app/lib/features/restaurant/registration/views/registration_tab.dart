import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_basic_info.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_detail_info.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_email_login.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_menu_delivery.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_payment.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/registration_representative_info.dart';

class RegistrationTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đăng ký thông tin'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(text: "Thông tin quán - Cơ bản"),
              Tab(text: "Thông tin người đại diện"),
              Tab(text: "Thông tin quán - Chi Tiết"),
              Tab(text: "Menu giao hàng - Ảnh chụp menu"),
              Tab(text: "Đăng ký Ứng dụng Shopee Partner"),
              Tab(text: "Đăng ký ví ShopeeFood Merchant Wallet"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RegistrationBasicInfo(),
            RegistrationRepresentativeInfo(),
            RegistrationDetailInfo(),
            RegistrationMenuDelivery(),
            RegistrationEmailLogin(),
            RegistrationPayment()
          ],
        ),
        bottomNavigationBar: RegistrationBottomNavigationBar(),
      ),
    );
  }
}
