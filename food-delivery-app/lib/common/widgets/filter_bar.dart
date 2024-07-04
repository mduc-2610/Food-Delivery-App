import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/controllers/filter_bar_controller.dart';
import 'package:food_delivery_app/common/widgets/icon_or_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FilterBar extends StatefulWidget {
  final List<String> filters;
  final String? suffixIconStr;
  final String? suffixIconStrClicked;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final Color? suffixIconColorClicked;
  final List<String> exclude;


  const FilterBar({
    Key? key,
    required this.filters,
    this.suffixIconStr,
    this.suffixIconStrClicked,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconColorClicked,
    this.exclude = const [],
  }) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  final FilterBarController _controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.filters.map((filter) {
          return Obx(() {
            final bool isSelected = _controller.selectedFilter.value == filter;
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
                    if (!THelperFunction.checkInArray(filter, widget.exclude)
                        && (
                            !THelperFunction.checkIfExistsNull(
                                [
                                  widget.suffixIconStr,
                                  widget.suffixIconStrClicked,
                                ]) ||
                                !THelperFunction.checkIfExistsNull(
                                    [
                                      widget.suffixIcon
                                    ])
                        )) ...[
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      IconOrSvg(
                        icon: widget.suffixIcon,
                        color: isSelected
                            ? widget.suffixIconColorClicked
                            : widget.suffixIconColor,
                        iconStr: isSelected
                            ? widget.suffixIconStrClicked
                            : widget.suffixIconStr,
                      )
                    ],
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    _controller.onFilterChanged(filter);
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
