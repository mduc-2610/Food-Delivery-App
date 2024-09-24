import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/controllers/bars/filter_bar_controller.dart';
import 'package:food_delivery_app/common/widgets/misc/icon_or_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FilterBar extends StatelessWidget {
  final List<String> filters;
  final String? suffixIconStr;
  final String? suffixIconStrClicked;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final Color? suffixIconColorClicked;
  final List<String> exclude;
  final FilterBarController controller;

  const FilterBar({
    Key? key,
    required this.filters,
    this.suffixIconStr,
    this.suffixIconStrClicked,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconColorClicked,
    this.exclude = const [],
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final FilterBarController _controller = FilterBarController("all", onTap);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: filters.map((filter) {
          return Obx(() {
            final bool isSelected = controller.selectedFilter.value == filter;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSize.xs),
              child: ChoiceChip(
                label: Row(
                  children: [
                    Text(
                      filter,
                      style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).appBarTheme.backgroundColor
                            : Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    if (!THelperFunction.checkInArray(filter, exclude)
                        && (
                            !THelperFunction.checkIfExistsNull(
                                [
                                  suffixIconStr,
                                  suffixIconStrClicked,
                                ]) ||
                                !THelperFunction.checkIfExistsNull(
                                    [
                                      suffixIcon
                                    ])
                        )) ...[
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      IconOrSvg(
                        icon: suffixIcon,
                        color: isSelected
                            ? suffixIconColorClicked
                            : suffixIconColor,
                        iconStr: isSelected
                            ? suffixIconStrClicked
                            : suffixIconStr,
                      )
                    ],
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    controller.onFilterChanged(filter);
                  }
                },
                selectedColor: TColor.primary,
              ),
            );
          });
        }).toList(),
      ),
    );
  }
}
