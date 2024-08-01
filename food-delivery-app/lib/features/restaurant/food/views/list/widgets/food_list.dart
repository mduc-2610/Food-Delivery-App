import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card_gr.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class FoodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total 3 items'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          for(int i = 0; i < 10; i++)...[
            FoodCard(
              type: FoodCardType.list,
              name: 'Burger',
              image: TImage.hcBurger1,
              stars: 4.0,
              originalPrice: 8.0,
              salePrice: 5.0,
              onTap: () {},
              reviewCount: '1.2k',
              tag: 'popular',
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical,),
          ]

        ],
      ),
    );
  }
}
