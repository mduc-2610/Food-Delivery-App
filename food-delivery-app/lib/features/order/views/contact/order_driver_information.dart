import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/order/views/contact/order_calling.dart';
import 'package:food_delivery_app/features/order/views/contact/order_message.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class OrderDriverInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Information'),
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
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(TImage.hcBurger1),
            ),
            SizedBox(height: 10),
            Text(
              'David Wayne',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('Driver'),
            SizedBox(height: 5),
            Text('4.9 ★', style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text('ID: DW9215', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.call),
              title: Text('Call'),
              subtitle: Text('+44 20 1234 5678'),
              onTap: () {
                Get.to(() => OrderCallingView());
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Message'),
              onTap: () {
                Get.to(() => OrderMessageView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
