import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class PersonalHelpDetailView extends StatelessWidget {
  final String title;
  final String content;

  PersonalHelpDetailView({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Help Detail",
          ),

          SliverToBoxAdapter(
            child: MainWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  Text(
                    content,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
