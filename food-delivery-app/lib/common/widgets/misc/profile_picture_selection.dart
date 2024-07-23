import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class ProfilePictureSelection extends StatelessWidget {
  final VoidCallback onPressed;
  ProfilePictureSelection({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(TSize.md),
      decoration: BoxDecoration(
        color: TColor.inputLightBackgroundColor,
        borderRadius: BorderRadius.circular(TSize.borderRadiusCircle),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Icon(
            Icons.person_rounded,
            size: 125,
            color: TColor.textDesc,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt_rounded, color: Colors.redAccent, size: TSize.xl),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}