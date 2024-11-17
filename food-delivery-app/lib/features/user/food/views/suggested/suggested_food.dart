import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card.dart';
import 'package:food_delivery_app/common/widgets/cards/suggested_food_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/controllers/suggested_food/suggested_food_controller.dart';
import 'package:food_delivery_app/utils/constants/emojis.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class SuggestedFoodView extends StatefulWidget {
  const SuggestedFoodView({super.key});

  @override
  State<SuggestedFoodView> createState() => _SuggestedFoodViewState();
}

class _SuggestedFoodViewState extends State<SuggestedFoodView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SuggestedFoodController controller = Get.put(SuggestedFoodController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);

    controller.loadPreferenceBasedDishes();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index == 1) {
        controller.loadWeatherBasedDishes();
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: 'Suggested Food ${TEmoji.starStruck}',
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Based on Preferences'),
            Tab(text: 'Based on Weather'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPreferencesTab(),
          _buildWeatherTab(),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return RefreshIndicator(
      onRefresh: () => controller.loadPreferenceBasedDishes(refresh: true),
      child: MainWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              CSearchBar(
                controller: controller.preferenceTextController,
                prefixPressed: controller.preferenceSearch,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Text(
                'Suggested food for you ${TEmoji.faceSavoringFood}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              Expanded(
                child: Obx(() {
                  if (controller.isLoadingPreferences.value && controller.preferenceBasedDishes.isEmpty) {
                    return _buildLoadingList();
                  }
                  return ListView.builder(
                    controller: controller.listScrollController,
                    itemCount: controller.preferenceBasedDishes.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.preferenceBasedDishes.length) {
                        return controller.hasMorePreferences
                            ? _buildLoadingIndicator()
                            : SizedBox();
                      }
                  
                      return SuggestedFoodCard(
                        type: FoodCardType.list,
                        dish: controller.preferenceBasedDishes[index],
                      );
                    },
                  );
                }),
              )
            ],
          ),
        )
    );
  }

  Widget _buildWeatherTab() {
    return RefreshIndicator(
      onRefresh: () => controller.loadWeatherBasedDishes(refresh: true),
      child: MainWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              CSearchBar(
                controller: controller.weatherTextController,
                prefixPressed: controller.weatherSearch,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Obx(() => Text(
                'Suggested food for you ${TEmoji.smilingFaceWithHeart}: ${controller.weather.value?.temperature}°C',
                style: Theme.of(context).textTheme.headlineSmall,
              ),),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Expanded(
                child: Obx(() {
                  if (controller.isLoadingWeather.value && controller.weatherBasedDishes.isEmpty) {
                    return _buildLoadingList();
                  }
                
                  return GridView.builder(
                    controller: controller.gridScrollController,
                    itemCount: controller.weatherBasedDishes.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: TSize.gridViewSpacing,
                      mainAxisSpacing: TSize.gridViewSpacing,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) {
                      if (index == controller.weatherBasedDishes.length) {
                        return controller.hasMoreWeather
                            ? _buildLoadingIndicator()
                            : const SizedBox();
                      }
                  
                      return SuggestedFoodCard(
                        type: FoodCardType.grid,
                        dish: controller.weatherBasedDishes[index],
                      );
                    },
                  );
                }),
              )
            ],
          ),
        )
    );
  }

  Widget _buildLoadingList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => SuggestedFoodCardListSkeleton(),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}