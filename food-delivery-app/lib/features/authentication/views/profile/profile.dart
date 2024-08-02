import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/features/authentication/controllers/profile/profile_controller.dart';
import 'package:food_delivery_app/features/authentication/views/profile/widgets/profile_detail.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Your Profile",
          ),
          SliverToBoxAdapter(
            child: ProfileDetail(
              // controller: _controller,
            ),
          ),
          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: MainWrapper(
          //     bottomMargin: 30,
          //     child:
          //   ),
          // ),
        ],
      ),
    );
  }
}
