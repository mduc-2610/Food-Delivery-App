import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class SuggestionLocationListSkeleton extends StatelessWidget {
  const SuggestionLocationListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 9,
      itemBuilder: (context, index) {
        return Column(
          children: [
            MainWrapperSection(
              child: Row(
                children: [
                  BoxSkeleton(
                    height: 40.0,
                    width: 40.0,
                    borderRadius: 20.0,
                  ),
                  SizedBox(width: 16.0),
                  BoxSkeleton(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width * 0.75,
                    borderRadius: 8.0,
                  ),
                ],
              ),
            ),
            SeparateSectionBar(),
          ],
        );
      },
    );
  }
}
