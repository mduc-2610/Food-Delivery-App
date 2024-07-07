import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skip_button.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_meal_rating.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_meal_rating.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class DeliveryDriverTipView extends StatefulWidget {
  @override
  _DeliveryDriverTipViewState createState() => _DeliveryDriverTipViewState();
}

class _DeliveryDriverTipViewState extends State<DeliveryDriverTipView> {
  int selectedAmount = -1;
  TextEditingController customAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give Thanks'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: MainWrapper(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: TSize.spaceBetweenSections),
                  Text(
                    'Rate your driver\'s delivery service.',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: TSize.spaceBetweenSections),

                  CircleAvatar(
                    radius: TSize.imageThumbSize,
                    backgroundImage: AssetImage(TImage.hcBurger1),
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  Text(
                    'David Wayne',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
                  ),
                  Text(
                    'Driver',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: TSize.spaceBetweenSections),
                ],
              ),

              Text(
                'Tip your delivery driver',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

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
        ),
      ),
      bottomNavigationBar: MainWrapper(
        bottomMargin: TSize.spaceBetweenSections,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SkipButton(
                onPressed: () {
                Get.to(DeliveryMealRatingView());
              },
                text: "No, thanks!",
              ),
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal,),
            Expanded(child: ElevatedButton(
              onPressed: () {
                Get.to(DeliveryMealRatingView());
              },
              child: Text('Submit'),
            ),)
          ],
        ),
      ),
    );
  }
}