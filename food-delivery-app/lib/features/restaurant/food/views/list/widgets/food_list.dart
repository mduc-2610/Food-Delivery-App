import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card_ls.dart';
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
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Chicken Thai Biriyani',
            subtitle: 'Burger',
            price: '60',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Chicken Bhuna',
            subtitle: 'Burger',
            price: '30',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Mazalichiken Halim',
            subtitle: 'Burger',
            price: '25',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Chicken Thai Biriyani',
            subtitle: 'Burger',
            price: '60',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Chicken Bhuna',
            subtitle: 'Burger',
            price: '30',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Mazalichiken Halim',
            subtitle: 'Burger',
            price: '25',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Chicken Thai Biriyani',
            subtitle: 'Burger',
            price: '60',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Chicken Bhuna',
            subtitle: 'Burger',
            price: '30',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Mazalichiken Halim',
            subtitle: 'Burger',
            price: '25',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Chicken Thai Biriyani',
            subtitle: 'Burger',
            price: '60',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Chicken Bhuna',
            subtitle: 'Burger',
            price: '30',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),
          FoodCardLs(
            imageUrl: TImage.hcBurger1,
            title: 'Mazalichiken Halim',
            subtitle: 'Burger',
            price: '25',
            rating: '4.9',
            reviewCount: '10',
            tag: 'Pick UP',
          ),



        ],
      ),
    );
  }
}
