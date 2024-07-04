import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/circle_icon_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';


class CSliverAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? backButtonOnPressed;
  final List<Map<String, dynamic>> iconList;
  final bool isBigTitle;
  final bool centerTitle;
  final bool noLeading;

  const CSliverAppBar({
    required this.title,
    this.iconList = const [],
    this.backButtonOnPressed,
    this.isBigTitle = false,
    this.centerTitle = true,
    this.noLeading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
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
            top: TDeviceUtil.getAppBarHeight() / 3,
            right: 16,
            child: Row(
              children: List.generate(
                iconList.length,
                    (index) => CircleIconCard(
                      elevation: TSize.iconCardElevation,
                      icon: iconList[index]["icon"],
                      onTap: iconList[index]["onPressed"],
                    )
              ),
            ),
          ),
        ],
      ),
      leading: (noLeading == false ) ? Padding(
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
      ) : null,
    );
  }
}

