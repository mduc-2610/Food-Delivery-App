import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/main_button.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/verification_controller.dart';

class VerificationView extends StatefulWidget {
  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final VerificationController _controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          CSliverAppBar(
            title: "Verification",
            isBigTitle: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: TDeviceUtil.getScreenHeight(),
                  child: MainWrapper(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Code has been sent to (+44) 20 **** 678',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            SizedBox(height: TSize.spaceBetweenSections),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                4,
                                    (index) => _buildCodeBox(
                                  index: index,
                                  focusNode: _controller.focusNodes[index],
                                  controller: _controller.controllers[index],
                                ),
                              ),
                            ),
                            SizedBox(height: TSize.spaceBetweenSections),
                            Column(
                              children: [
                                Text(
                                  "Didn’t receive code?",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(height: TSize.spaceBetweenItemsVertical),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.timer, color: Theme.of(context).textTheme.bodySmall?.color),
                                    SizedBox(width: 5),
                                    Obx(() => Text(
                                      '00:${_controller.timer.value.toString().padLeft(2, '0')}',
                                      style: Theme.of(context).textTheme.bodyLarge
                                    )),
                                  ],
                                ),
                                SizedBox(height: TSize.spaceBetweenItemsVertical),
                                Center(
                                  child: Obx(() => GestureDetector(
                                    onTap: _controller.isCodeSent.value ? null : _controller.startTimer,
                                    child: Text(
                                      'Resend Code',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: (_controller.isCodeSent.value)
                                              ? null : TColor.primary),
                                    ),
                                  )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: TDeviceUtil.getBottomNavigationBarHeight() * 2.2 ,
                  child: MainWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MainButton(
                          onPressed: _controller.handleVerify,
                          text: "Verify",
                        ),
                        SizedBox(height: TSize.spaceBetweenItemsVertical),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Back to ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            GestureDetector(
                              onTap: _controller.loginRedirect,
                              child: Text(
                                "Sign In",
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBox({
    required int index,
    required FocusNode focusNode,
    required TextEditingController controller,
  }) {
    final VerificationController verificationController = Get.find();
    return Container(
      width: 70,
      height: 70, // Adjusted height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          textAlign: TextAlign.center,
          maxLength: 1,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: TSize.lg),
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.symmetric(vertical: 20),
            isDense: true,
            counterText: "",
          ),
          onChanged: (value) {
            verificationController.handleInputChange(value, index);
          },
        ),
      ),
    );
  }
}
