import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';


class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? backButtonOnPressed;
  final List<Map<String, dynamic>> iconList;
  final bool isBigTitle;
  final bool centerTitle;

  const CustomSliverAppBar({
    required this.title,
    this.iconList = const [],
    this.backButtonOnPressed,
    this.isBigTitle = false,
    this.centerTitle = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: (isBigTitle)
            ? Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary)
            : Theme.of(context).textTheme.headlineMedium,
      ),
      expandedHeight: TDeviceUtil.getAppBarHeight(),
      centerTitle: centerTitle,
      flexibleSpace: Stack(
        children: [
          Positioned(
            top: TDeviceUtil.getAppBarHeight() / 2,
            right: 16,
            child: Row(
              children: List.generate(
                iconList.length,
                    (index) => IconButton(
                  icon: Icon(iconList[index]["icon"]),
                  onPressed: iconList[index]["onPressed"],
                ),
              ),
            ),
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              backButtonOnPressed?.call();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}

