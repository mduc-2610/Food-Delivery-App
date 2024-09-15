import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/controllers/profile/profile_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class ProfilePictureSelection extends StatelessWidget {
  final VoidCallback onPressed;
  final String? avatar;

  const ProfilePictureSelection({
    required this.onPressed,
    this.avatar,
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
          (avatar == null)
          ? Icon(
            Icons.person_rounded,
            size: 125,
            color: TColor.textDesc,
          )
          : Image.network(
            "${avatar}",
            width: 125,
            height: 125,
            fit: BoxFit.cover,
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