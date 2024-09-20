import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/first/widgets/registration_activity_info.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/first/widgets/registration_basic_info.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/first/widgets/registration_driver_license.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/first/widgets/registration_emergency_contact.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/first/widgets/registration_other_info.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/first/widgets/registration_residency_info.dart';
import 'package:get/get.dart';

class RegistrationFirstStepView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(Icons.arrow_back, color: Colors.black),
          title: Text('Nộp giấy tờ', style: TextStyle(color: Colors.black)),
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text('Hỗ trợ', style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(child: Text(
                  "Thông tin cơ bản",
                  style: Get.textTheme.bodyMedium,
                ),),
                Tab(child: Text(
                  "Thông tin cư trú",
                  style: Get.textTheme.bodyMedium,
                ),),
                Tab(child: Text(
                  "Thông tin hoạt động",
                  style: Get.textTheme.bodyMedium,
                ),),
                Tab(child: Text(
                  "Lien he khan cap",
                  style: Get.textTheme.bodyMedium,
                ),),
                Tab(child: Text(
                  "Bang lai & phuong tien",
                  style: Get.textTheme.bodyMedium,
                ),),
                Tab(child: Text(
                  "Thong tin khac",
                  style: Get.textTheme.bodyMedium,
                ),)
              ]
          ),
        ),
        body: TabBarView(
          children: [
            RegistrationBasicInfo(),
            RegistrationResidencyInfo(),
            RegistrationActivityInfo(),
            RegistrationEmergencyContact(),
            RegistrationDriverLicense(),
            RegistrationOtherInfo()
          ],
        ),
      ),
    );
  }
}