import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RevenueTimeFilter extends StatefulWidget {
  const RevenueTimeFilter({super.key});

  @override
  State<RevenueTimeFilter> createState() => _RevenueTimeFilterState();
}

class _RevenueTimeFilterState extends State<RevenueTimeFilter> {
  String _selectedFilter = "Daily";
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Revenue', style: Theme.of(context).textTheme.titleSmall,),
            Text('\$2,241', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
        SizedBox(width: TSize.spaceBetweenItemsHorizontal * 2,),
        DropdownButton<String>(
          value: _selectedFilter,
          items: ['Daily', 'Weekly', 'Monthly', 'Yearly', 'All Time']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedFilter = newValue!;
            });
          },
        ),
      ],
    );;
  }
}
