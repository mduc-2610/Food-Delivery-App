import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/order/views/rating/rating_order.dart';
import 'package:food_delivery_app/features/order/views/rating/rating_driver_tip.dart';

class DeliverySuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 60, color: Colors.green),
                      SizedBox(height: 16),
                      Text(
                        'Delivery Successful',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text('Enjoy your meal! See you in the next order!'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RatingDriverTipView()),
                          );
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Text('Show Delivery Success'),
        ),
      ),
    );
  }
}