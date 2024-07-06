import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_driver_tip.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_driver_tip.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class DeliveryDriverRatingView extends StatefulWidget {
  @override
  _DeliveryDriverRatingViewState createState() => _DeliveryDriverRatingViewState();
}

class _DeliveryDriverRatingViewState extends State<DeliveryDriverRatingView> {
  int _rating = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Rating'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Rate your driver\'s delivery service',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(TImage.hcBurger1), // Add a driver image in assets
          ),
          SizedBox(height: 10),
          Text(
            'David Wayne',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('Driver'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Type your review...',
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.to(DeliveryDriverTipView());
                },
                child: Text('Skip'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(DeliveryDriverTipView());
                },
                child: Text('Submit'),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}