import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class DriverTip extends StatefulWidget {
  const DriverTip({super.key});

  @override
  State<DriverTip> createState() => _DriverTipState();
}

class _DriverTipState extends State<DriverTip> {
  TextEditingController customAmountController = TextEditingController();
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextField(
            controller: customAmountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter custom amount',
              prefixText: '£',
            ),
            onChanged: (value) {
              setState(() {
                selectedAmount = -1;
              });
            },
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical),

          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              children: List.generate(8, (index) {
                int amount = index + 1;
                return ChoiceChip(
                  showCheckmark: false,
                  label: Text(
                    '£$amount',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: (selectedAmount == amount) ? TColor.light : TColor.primary),
                  ),
                  selected: selectedAmount == amount,
                  onSelected: (selected) {
                    setState(() {
                      selectedAmount = selected ? amount : -1;
                      customAmountController.clear();
                    });
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
