import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class FoodDetailReviewFilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const FoodDetailReviewFilterBar({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Positive', 'Negative', '5', '4', '3', '2', '1'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: filters.map((filter) {
          final bool isSelected = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSize.xs),
            child: ChoiceChip(
              label: Row(
                children: [
                  Text(
                    "${filter}",
                    style: TextStyle(
                      color: (filter == selectedFilter)
                          ? Theme.of(context).appBarTheme.backgroundColor
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    // style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                  ),
                  if(filter != 'All' && filter != 'Positive' && filter != 'Negative')...[
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal,),
                    SvgPicture.asset(
                        (filter == selectedFilter)
                            ? TIcon.fillStarWhite
                            : TIcon.unearnedStar
                    )
                  ]
                ],
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onFilterChanged(filter);
                }
              },
              selectedColor: TColor.primary,
            ),
          );
        }).toList(),
      ),
    );
  }
}