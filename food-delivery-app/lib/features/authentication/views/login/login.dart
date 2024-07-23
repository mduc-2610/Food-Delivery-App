import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _controller.page.value,
      ),
    );
  }
}
