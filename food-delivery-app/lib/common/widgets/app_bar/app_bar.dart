import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final VoidCallback? backButtonOnPressed;
  final List<Map<String, dynamic>> iconList;
  final bool isBigTitle;
  final bool centerTitle;
  final bool noLeading;
  final PreferredSizeWidget? bottom;

  const CAppBar({
    this.title,
    this.iconList = const [],
    this.backButtonOnPressed,
    this.isBigTitle = false,
    this.centerTitle = true,
    this.noLeading = false,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title is Widget
          ? title
          : Text(
        title.toString(),
        style: isBigTitle
            ? Theme.of(context)
            .textTheme
            .headlineLarge
            ?.copyWith(color: TColor.primary)
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
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      TSize.appBarHeight + (bottom?.preferredSize.height ?? 0.0));
}
