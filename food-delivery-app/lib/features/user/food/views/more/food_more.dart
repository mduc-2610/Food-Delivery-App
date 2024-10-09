import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/food/views/common/widgets/category_card.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:get/get.dart';

class FoodMoreView extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Categories",
          ),
          SliverToBoxAdapter(
            child: MainWrapper(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CategoryCard(label: 'Burger', icon: TIcon.burger, onTap: () {_controller.getToFoodCategory("Burger");}),
                  CategoryCard(label: 'Taco', icon: TIcon.taco, onTap: () {_controller.getToFoodCategory("Taco");}),
                  CategoryCard(label: 'Burrito', icon: TIcon.burrito, onTap: () {_controller.getToFoodCategory("Burrito");}),
                  CategoryCard(label: 'Drink', icon: TIcon.drink, onTap: () {_controller.getToFoodCategory("Drink");}),
                  CategoryCard(label: 'Pizza', icon: TIcon.pizza, onTap: () {_controller.getToFoodCategory("Pizza");}),
                  CategoryCard(label: 'Donut', icon: TIcon.donut, onTap: () {_controller.getToFoodCategory("Donut");}),
                  CategoryCard(label: 'Salad', icon: TIcon.salad, onTap: () {_controller.getToFoodCategory("Salad");}),
                  CategoryCard(label: 'Noodles', icon: TIcon.noodles, onTap: () {_controller.getToFoodCategory("Noodles");}),
                  CategoryCard(label: 'Sandwich', icon: TIcon.sandwich, onTap: () {_controller.getToFoodCategory("Sandwich");}),
                  CategoryCard(label: 'Pasta', icon: TIcon.pasta, onTap: () {_controller.getToFoodCategory("Pasta");}),
                  CategoryCard(label: 'Ice Cream', icon: TIcon.iceCream, onTap: () {_controller.getToFoodCategory("Ice Cream");}),
                  CategoryCard(label: 'Rice', icon: TIcon.rice, onTap: () {_controller.getToFoodCategory("Rice");}),
                  CategoryCard(label: 'Takoyaki', icon: TIcon.takoyaki, onTap: () {_controller.getToFoodCategory("Takoyaki");}),
                  CategoryCard(label: 'Fruit', icon: TIcon.fruit, onTap: () {_controller.getToFoodCategory("Fruit");}),
                  CategoryCard(label: 'Sausage', icon: TIcon.sausage, onTap: () {_controller.getToFoodCategory("Sausage");}),
                  CategoryCard(label: 'Goi Cuon', icon: TIcon.goiCuon, onTap: () {_controller.getToFoodCategory("Goi Cuon");}),
                  CategoryCard(label: 'Cookie', icon: TIcon.cookie, onTap: () {_controller.getToFoodCategory("Cookie");}),
                  CategoryCard(label: 'Pudding', icon: TIcon.pudding, onTap: () {_controller.getToFoodCategory("Pudding");}),
                  CategoryCard(label: 'Banh Mi', icon: TIcon.banhMi, onTap: () {_controller.getToFoodCategory("Banh Mi");}),
                  CategoryCard(label: 'Dumpling', icon: TIcon.dumpling, onTap: () {_controller.getToFoodCategory("Dumpling");}),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
