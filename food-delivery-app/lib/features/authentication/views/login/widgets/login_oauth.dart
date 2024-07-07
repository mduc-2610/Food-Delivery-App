import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/login_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class LoginOauth extends StatefulWidget {
  final bool isLogin;
  const LoginOauth({
    this.isLogin = true,
    super.key
  });

  @override
  State<LoginOauth> createState() => _LoginOauthState();
}

class _LoginOauthState extends State<LoginOauth> {
  final LoginController _controller = LoginController.instance;

  late String buttonText;
  late VoidCallback onPressed;
  late VoidCallback onTap;
  late String text1, text2;

  @override
  void initState() {
    bool isLogin = widget.isLogin;
    buttonText = (isLogin) ? "Sign in" : "Register";
    onPressed = (isLogin) ? _controller.handleLogin : _controller.handleRegister;
    onTap = (isLogin) ? _controller.showRegisterPage : _controller.showLoginPage;
    text1 = (isLogin) ? "Don't have an account? " : "Already have an account? ";
    text2 = (isLogin) ? "Register" : "Login";
    super.initState();
  }

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
            MainButton(
              onPressed: onPressed,
              text: buttonText,
            ),
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
                  "Or Sign In with",
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
                    onTap: iconPaths[i]["onPressed"], // Ensure to call the correct function
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text1,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    text2,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: TColor.primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
