import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_meal_rating.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_meal_rating.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(TImage.hcBurger1),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'David Wayne',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Driver'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Tip your delivery driver'),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(8, (index) {
                int amount = index + 1;
                return ChoiceChip(
                  label: Text('£$amount'),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => DeliveryMealRatingView());
              },
              child: Text('Pay Tip'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => DeliveryMealRatingView());
              },
              child: Text('No. Thanks!'),
            ),
          ],
        ),
      ),
    );
  }
}