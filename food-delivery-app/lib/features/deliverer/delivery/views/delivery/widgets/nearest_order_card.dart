import 'package:flutter/material.dart';

class NearestOrderCard extends StatelessWidget {
  final String orderNumber;
  final String restaurantName;
  final double distance;
  final double estimatedPay;
  final VoidCallback onPressed;

  const NearestOrderCard({
    Key? key,
    required this.orderNumber,
    required this.restaurantName,
    required this.distance,
    required this.estimatedPay,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #$orderNumber',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(restaurantName),
            SizedBox(height: 8),
            Text('$distance miles away • \$${estimatedPay.toStringAsFixed(2)} estimated pay'),
            Spacer(),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('Accept'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.green,
                minimumSize: Size(double.infinity, 36),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

