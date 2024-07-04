import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? backButtonOnPressed;
  final List<Map<String, dynamic>> iconList;
  final bool isBigTitle;
  final bool centerTitle;
  final bool noLeading;

  const CAppBar({
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
    return AppBar(
      title: Text(
        title,
        style: isBigTitle
            ? Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary)
            : Theme.of(context).textTheme.headlineMedium,
      ),
      centerTitle: centerTitle,
      leading: noLeading
          ? null
          : IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          backButtonOnPressed?.call();
          Navigator.pop(context);
        },
      ),
      actions: iconList.map((iconData) {
        return CircleIconCard(
          elevation: TSize.iconCardElevation,
          icon: iconData['icon'],
          onTap: iconData['onPressed'],
        );
      }).toList(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TSize.appBarHeight);
}
