import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class LoginOauth extends StatefulWidget {
  const LoginOauth({
    super.key
  });

  @override
  State<LoginOauth> createState() => _LoginOauthState();
}

class _LoginOauthState extends State<LoginOauth> {
  final AuthController _controller = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> iconPaths = [
      {"icon": TIcon.googleIcon, "onPressed": () {}},
      {"icon": TIcon.facebookIcon, "onPressed": () {}},
      {"icon": TIcon.appleIcon, "onPressed": () {}}
    ];

    return Positioned(
      left: 0,
      right: 0,
      bottom: TDeviceUtil.getBottomNavigationBarHeight(),
      child: MainWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => MainButton(
              onPressed:
                  (_controller.isButtonEnabled)
                  ? _controller.handleLogin
                  : null,
              text: "Login",
            )),
            SizedBox(
              height: TSize.spaceBetweenSections,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                SizedBox(
                  width: TSize.spaceBetweenItemsVertical,
                ),
                Text(
                  "Or Login with",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  width: TSize.spaceBetweenItemsVertical,
                ),
                Expanded(
                  child: Divider(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: TSize.spaceBetweenItemsVertical,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < iconPaths.length; i++) ...[
                  GestureDetector(
                    onTap: iconPaths[i]["onPressed"],
                    child: Container(
                      margin: EdgeInsets.only(
                          right: (i < iconPaths.length - 1)
                              ? TSize.spaceBetweenItemsVertical
                              : 0),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).textTheme.bodySmall?.color
                            ?? Colors.black.withOpacity(0.5), width: 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: SvgPicture.asset(
                        iconPaths[i]["icon"],
                        width: 30,
                        height: 30,
                      ),
                    ),
                  )
                ]
              ],
            ),
            SizedBox(
              height: TSize.spaceBetweenItemsVertical,
            ),
          ],
        ),
      ),
    );
  }
}
