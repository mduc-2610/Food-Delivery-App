import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class OrderCallingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: TSize.imageThumbSize,
                  backgroundImage: AssetImage(TImage.hcBurger1),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),
                Text(
                  'Calling...',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                Text(
                  'David Wayne',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.call_end, color: Colors.red, size: TSize.iconLg),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.call, color: Colors.green, size: TSize.iconLg),
                      onPressed: () {
                        // Handle call action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_down, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
